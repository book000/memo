# GitHub Copilot 指示書

このファイルは GitHub Copilot がこのプロジェクトで効果的に動作するためのルールと指針を定めています。

## プロジェクト概要

このリポジトリは技術的なさまざまな分野に関するメモです。Linux 系や各種プログラミング言語、フレームワークなどの自分用メモ（備忘録）を含んでいます。

- プロジェクト名: book000/memo
- サイト URL: https://memo.tomacheese.com
- ライセンス: CC BY-SA 4.0
- 主言語: 日本語
- 静的サイトジェネレーター: MkDocs with Material theme

## 技術スタック

- パッケージマネージャー: pnpm
- 静的サイトジェネレーター: MkDocs
- テーマ: Material for MkDocs
- リンター: textlint（日本語文書用）、markdownlint
- CI/CD: GitHub Actions
- 開発環境: Visual Studio Code

## 開発ルール

### コミュニケーション

- すべての会話（PR 本文、レビューへの対応など）は**日本語**で行うこと
- ただし、PR のタイトルは**英語**とすること
- PR のタイトル、コミットメッセージは Conventional Commits の仕様に沿うこと

### コミット規約

Conventional Commits の形式を使用します。

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

主要なタイプ。
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメントのみの変更
- `style`: コードの意味に影響しない変更（空白、フォーマットなど）
- `refactor`: バグ修正も機能追加もしないコード変更
- `test`: テストの追加や修正
- `chore`: ビルドプロセスやツールの変更

### ファイル構造

```
memo/
├── .github/           # GitHub 設定
├── .vscode/           # VS Code 設定
├── docs/              # ドキュメントファイル
│   ├── assets/        # 画像などの静的ファイル
│   ├── css/           # カスタム CSS
│   ├── etc/           # その他のメモ
│   ├── game/          # ゲーム関連のメモ
│   ├── os/            # OS 関連のメモ
│   └── programming/   # プログラミング関連のメモ
├── scripts/           # ビルドスクリプト
├── mkdocs.yml         # MkDocs 設定
├── package.json       # Node.js 依存関係
└── requirements.txt   # Python 依存関係
```

## 文書作成ガイドライン

### 日本語文書の品質

このプロジェクトでは textlint を使用して日本語文書の品質を保っています。以下のルールに従ってください。

1. 句読点は句点（。）と読点（、）を正しく使用する
2. 表記統一は同じ意味の言葉で統一した表記を使用する
3. 助詞の重複では同じ助詞の連続使用を避ける
4. 敬語では「ですます」調と「である」調の混在を避ける
5. 半角・全角では英数字は半角、日本語は全角を基本とする
6. スペースでは全角文字と半角文字の間に必要なスペースを入れる

### Markdown 記法

- 見出しレベルは h1 から順序良く使用する（h1 は 1 つのファイルに 1 つ）
- コードブロックには言語を指定する
- リンクは明確でわかりやすい形式で記述する
- 画像には alt テキストをつける

### コード例の記述

```markdown
## 例：Node.js のコード

```javascript
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello World!');
});
```

## ツール使用方法

### textlint の実行

```bash
# 文書をチェック
pnpm run lint

# 自動修正
pnpm run fix
```

### MkDocs の起動（ローカル開発）

```bash
# Python 環境で MkDocs を起動
mkdocs serve
```

### パッケージ管理

```bash
# 依存関係のインストール
pnpm install

# パッケージの追加
pnpm add <package-name>
```

## GitHub Actions

以下のワークフローが設定されています。

- build.yml: ビルドチェック
- nodejs-ci-pnpm.yml: Node.js CI with pnpm
- pages-deploy.yml: GitHub Pages デプロイ

## 推奨事項

### 新しいメモの作成

1. わかりやすいカテゴリ（`docs/programming/`, `docs/os/` など）にファイルを配置
2. ファイル名は小文字とハイフンを使用（例：`nodejs-project.md`）
3. 前書きとして目的や概要を記述
4. 実際のコード例やスクリーンショットを含める

### 既存メモの更新

1. 情報の正確性を確認
2. 古い情報は削除または更新
3. 新しい手法やツールがあれば追加
4. textlint でチェックを実行

### プルリクエスト

1. タイトルは英語で Conventional Commits 形式
2. 説明は日本語で詳細に記述
3. 変更理由と影響範囲を明記
4. 関連 Issue があれば参照

## 禁止事項

- 機密情報やパスワードなどの秘匿すべき情報の記載
- 著作権に触れる可能性のあるコードやコンテンツのコピー
- 不適切な言葉や差別的な内容の記載
- TODO コメントの残存（`.textlintrc` で禁止設定済み）

## 参考リンク

- [MkDocs 公式ドキュメント](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- [textlint 公式サイト](https://textlint.github.io/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [CC BY-SA 4.0 ライセンス](https://creativecommons.org/licenses/by-sa/4.0/deed.ja)