# etckeeper のセットアップ

Ubuntu で etckeeper を使用して `/etc` ディレクトリの変更履歴を Git で管理する方法について説明する。

## etckeeper とは

etckeeper は `/etc` ディレクトリの変更を自動的にバージョン管理システム（Git、Mercurial、Bazaar、Darcs）で追跡するツール。  
システムの設定変更を記録し、必要に応じて変更を元に戻すことができる。

## 環境

Ubuntu 22.04 LTS での動作を確認済み。他のバージョンでも同様に動作する。

## 前提知識

- Git の基本的な操作方法
- SSH キーの設定（リモートリポジトリを使用する場合）

SSH キーの設定については [GitHub へのキー登録](github-key.md) を参照。

## セットアップ手順

### 1. etckeeper のインストール

以下のコマンドで etckeeper をインストールする。

```bash
sudo apt install etckeeper
```

### 2. SSH キーまたは Git 設定のコピー

リモートリポジトリを使用する場合、SSH キーや Git の設定を事前に準備する。  
詳細は [GitHub へのキー登録](github-key.md) を参照。

### 3. etckeeper の設定

`/etc/etckeeper/etckeeper.conf` を編集し、使用するバージョン管理システムとリモートリポジトリを設定する。

```bash
sudo vim /etc/etckeeper/etckeeper.conf
```

以下の設定を変更する。

```bash
# 使用するバージョン管理システムを指定（デフォルトは git）
VCS="git"

# リモートリポジトリにプッシュする場合は有効にする
PUSH_REMOTE="origin"
```

### 4. Git リポジトリの初期化

既存の `.git` ディレクトリがある場合は削除してから、etckeeper で Git リポジトリを初期化する。

```bash
cd /etc
sudo rm -rfv .git
sudo etckeeper init
```

### 5. リモートリポジトリの設定

GitHub などのリモートリポジトリを使用する場合、リモートを追加する。  
`{machine-name}` は適切なマシン名に置き換える。

```bash
sudo git remote add origin git@github.com:tomacheese/etckeeper-{machine-name}.git
```

### 6. 初期コミットとプッシュ

初期コミットを作成し、リモートリポジトリにプッシュする。

```bash
sudo etckeeper commit -m "first commit"
sudo git push --set-upstream origin master
```

### 7. 自動プッシュの設定

毎日自動的にリモートリポジトリにプッシュするため、`/etc/etckeeper/daily` を編集する。

```bash
sudo vim /etc/etckeeper/daily
```

ファイルの最後に以下の行を追加する。

```bash
git push -u origin master
```

## 使用方法

### 手動コミット

設定変更後に手動でコミットする場合。

```bash
sudo etckeeper commit -m "コミットメッセージ"
```

### 自動コミット

etckeeper は以下のタイミングで自動的にコミットを行う。

- パッケージのインストール前後
- 毎日の cron ジョブ実行時（`/etc/etckeeper/daily` が実行される）

### 変更履歴の確認

Git コマンドで変更履歴を確認できる。

```bash
cd /etc
sudo git log --oneline
sudo git diff HEAD~1
```

## 注意事項

- `/etc` ディレクトリは機密情報を含む可能性があるため、リモートリポジトリは private に設定することを推奨
- `sudo` 権限が必要な操作が多いため、コマンド実行時は注意する
- 自動プッシュを設定する場合、SSH キーのパスフレーズは設定しないか、ssh-agent を適切に設定する

## トラブルシューティング

### リモートプッシュが失敗する場合

SSH キーの設定や権限を確認する。以下のコマンドで接続テストを行う。

```bash
sudo ssh -T git@github.com
```

### Git の設定が不十分な場合

Git のユーザー情報を設定する。

```bash
sudo git config --global user.name "Your Name"
sudo git config --global user.email "your.email@example.com"
```