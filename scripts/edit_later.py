#!/usr/bin/env python3
"""
Edit Later機能
PRやIssueのコメントで「edit later」が検出されたときに、
自動的にIssueを作成し、元のコメントにIssue番号を追加する。
"""

import os
import sys
import json
import re
from typing import Dict, Any, Optional
import requests


class EditLaterProcessor:
    def __init__(self):
        self.github_token = os.environ.get('GITHUB_TOKEN')
        self.repo_owner = os.environ.get('GITHUB_REPOSITORY_OWNER')
        self.repo_name = os.environ.get('GITHUB_REPOSITORY', '').split('/')[-1]
        
        if not all([self.github_token, self.repo_owner, self.repo_name]):
            raise ValueError("必要な環境変数が設定されていません")
        
        self.headers = {
            'Authorization': f'token {self.github_token}',
            'Accept': 'application/vnd.github.v3+json'
        }
        self.base_url = 'https://api.github.com'

    def detect_edit_later(self, comment_body: str) -> bool:
        """コメント内で「edit later」を検出"""
        pattern = r'\bedit\s+later\b'
        return bool(re.search(pattern, comment_body, re.IGNORECASE))

    def extract_context(self, event_data: Dict[str, Any]) -> Dict[str, Any]:
        """イベントデータからコンテキスト情報を抽出"""
        comment = event_data.get('comment', {})
        
        context = {
            'comment_id': comment.get('id'),
            'comment_body': comment.get('body', ''),
            'comment_user': comment.get('user', {}).get('login'),
            'comment_url': comment.get('html_url'),
        }
        
        # PR関連の情報
        if 'pull_request' in event_data:
            pr = event_data['pull_request']
            context.update({
                'type': 'pull_request',
                'number': pr.get('number'),
                'title': pr.get('title'),
                'url': pr.get('html_url'),
                'head_sha': pr.get('head', {}).get('sha'),
                'base_branch': pr.get('base', {}).get('ref'),
                'head_branch': pr.get('head', {}).get('ref'),
            })
        
        # Issue関連の情報
        elif 'issue' in event_data:
            issue = event_data['issue']
            context.update({
                'type': 'issue',
                'number': issue.get('number'),
                'title': issue.get('title'),
                'url': issue.get('html_url'),
            })
        
        return context

    def create_issue(self, context: Dict[str, Any]) -> Optional[int]:
        """新しいIssueを作成"""
        if context['type'] == 'pull_request':
            title = f"Edit later: {context['title']} (PR #{context['number']})"
            body_parts = [
                f"## Edit Later Request",
                f"",
                f"**Original Comment:** {context['comment_url']}",
                f"**PR:** #{context['number']} - {context['title']}",
                f"**Branch:** {context['head_branch']} → {context['base_branch']}",
                f"**Requested by:** @{context['comment_user']}",
                f"",
                f"### Original Comment",
                f"```",
                f"{context['comment_body']}",
                f"```",
                f"",
                f"### TODO",
                f"- [ ] 必要な編集内容を特定",
                f"- [ ] 編集を実施",
                f"- [ ] テスト・確認",
            ]
        else:  # issue
            title = f"Edit later: {context['title']} (Issue #{context['number']})"
            body_parts = [
                f"## Edit Later Request",
                f"",
                f"**Original Comment:** {context['comment_url']}",
                f"**Issue:** #{context['number']} - {context['title']}",
                f"**Requested by:** @{context['comment_user']}",
                f"",
                f"### Original Comment",
                f"```",
                f"{context['comment_body']}",
                f"```",
                f"",
                f"### TODO",
                f"- [ ] 必要な編集内容を特定",
                f"- [ ] 編集を実施",
                f"- [ ] テスト・確認",
            ]
        
        body = "\n".join(body_parts)
        
        payload = {
            'title': title,
            'body': body,
            'labels': ['edit-later']
        }
        
        url = f"{self.base_url}/repos/{self.repo_owner}/{self.repo_name}/issues"
        response = requests.post(url, headers=self.headers, json=payload)
        
        if response.status_code == 201:
            issue_data = response.json()
            return issue_data['number']
        else:
            print(f"Issue作成エラー: {response.status_code} - {response.text}")
            return None

    def add_reply_comment(self, context: Dict[str, Any], issue_number: int) -> bool:
        """元のコメントに返信してIssue番号を追加"""
        reply_body = f"Edit later request has been tracked in issue #{issue_number} 📝"
        
        if context['type'] == 'pull_request':
            url = f"{self.base_url}/repos/{self.repo_owner}/{self.repo_name}/issues/{context['number']}/comments"
        else:  # issue
            url = f"{self.base_url}/repos/{self.repo_owner}/{self.repo_name}/issues/{context['number']}/comments"
        
        payload = {'body': reply_body}
        response = requests.post(url, headers=self.headers, json=payload)
        
        return response.status_code == 201

    def process_event(self, event_data: Dict[str, Any]) -> bool:
        """イベントを処理"""
        try:
            # コメントの存在確認
            if 'comment' not in event_data:
                print("コメントが見つかりません")
                return False
            
            comment_body = event_data['comment'].get('body', '')
            
            # edit laterの検出
            if not self.detect_edit_later(comment_body):
                print("edit laterが検出されませんでした")
                return False
            
            print("edit laterを検出しました")
            
            # コンテキスト抽出
            context = self.extract_context(event_data)
            
            if not context.get('type'):
                print("サポートされていないイベントタイプです")
                return False
            
            print(f"処理対象: {context['type']} #{context['number']}")
            
            # Issue作成
            issue_number = self.create_issue(context)
            if not issue_number:
                print("Issue作成に失敗しました")
                return False
            
            print(f"Issue #{issue_number} を作成しました")
            
            # 返信コメント追加
            if self.add_reply_comment(context, issue_number):
                print(f"返信コメントを追加しました")
                return True
            else:
                print("返信コメントの追加に失敗しました")
                return False
                
        except Exception as e:
            print(f"処理エラー: {str(e)}")
            return False


def main():
    """メイン処理"""
    try:
        # GitHub Actionsからイベントデータを取得
        event_path = os.environ.get('GITHUB_EVENT_PATH')
        if not event_path:
            print("GITHUB_EVENT_PATHが設定されていません")
            sys.exit(1)
        
        with open(event_path, 'r', encoding='utf-8') as f:
            event_data = json.load(f)
        
        # 処理実行
        processor = EditLaterProcessor()
        success = processor.process_event(event_data)
        
        if success:
            print("Edit later処理が正常に完了しました")
            sys.exit(0)
        else:
            print("Edit later処理に失敗しました")
            sys.exit(1)
            
    except Exception as e:
        print(f"メイン処理エラー: {str(e)}")
        sys.exit(1)


if __name__ == '__main__':
    main()