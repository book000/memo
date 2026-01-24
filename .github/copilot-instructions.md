# GitHub Copilot Instructions

## プロジェクト概要
Technical knowledge base and personal notes repository covering Linux, programming languages, and frameworks, published as a documentation site.

## 共通ルール
- 会話は日本語で行う。
- PR とコミットは Conventional Commits に従う。
- PR タイトルとコミット本文の言語: PR タイトルは Conventional Commits 形式（英語推奨）。PR 本文は日本語。コミットは Conventional Commits 形式（description は日本語）。
- 日本語と英数字の間には半角スペースを入れる。
- 既存のプロジェクトルールがある場合はそれを優先する。

## 技術スタック
- 言語: Markdown, Python (MkDocs)
- パッケージマネージャー: pnpm@10.28.1

## コーディング規約
- フォーマット: 既存設定（ESLint / Prettier / formatter）に従う。
- 命名規則: 既存のコード規約に従う。
- Lint / Format: 既存の Lint / Format 設定に従う。
- コメント言語: 日本語
- エラーメッセージ: 英語
- TypeScript 使用時は strict 前提とし、`skipLibCheck` で回避しない。
- 関数やインターフェースには docstring（JSDoc など）を記載する。

### 開発コマンド
```bash
# install
pnpm install

# dev
mkdocs serve (via VS Code devcontainer)

# build
mkdocs build

# test
None

# lint
textlint docs/

# fix
textlint --fix docs/

```

## テスト方針
- 新機能や修正には適切なテストを追加する。

## セキュリティ / 機密情報
- 認証情報やトークンはコミットしない。
- ログに機密情報を出力しない。

## ドキュメント更新
- 実装確定後、同一コミットまたは追加コミットで更新する。
- README、API ドキュメント、コメント等は常に最新状態を保つ。

## リポジトリ固有
- **documentation_format**: Markdown (MkDocs site: memo.tomacheese.com)
- **language_focus**: Japanese with technical English terms
- **writing_tools**: textlint with extensive Japanese rule sets
**quality_checks:**
  - markdownlint for markdown structure
  - textlint for Japanese language quality
  - prh for typo checking
- **license**: CC BY-SA 4.0
- **development_environment**: VS Code devcontainer with Python/MkDocs