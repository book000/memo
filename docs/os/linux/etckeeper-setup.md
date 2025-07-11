# etckeeper のセットアップ

Ubuntu で etckeeper を使用して `/etc` ディレクトリの変更履歴を Git で管理する方法について説明する。

## etckeeper とは

etckeeper は `/etc` ディレクトリの変更を自動的にバージョン管理システム（Git、Mercurial、Bazaar、Darcs）で追跡するツール。  
システムの設定変更を記録し、必要に応じて変更を元に戻すことができる。

## 環境

以下の環境で動作を確認済み。

- Ubuntu 22.04.5 LTS (Jammy Jellyfish)
- Git 2.34.1
- etckeeper 1.18.16

他の Ubuntu バージョンでも同様に動作する。

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

以下のコマンドで設定を変更する。

```bash
# VCS設定を git に変更
sudo sed -i 's/^#VCS="git"/VCS="git"/' /etc/etckeeper/etckeeper.conf

# PUSH_REMOTE設定を有効にする
sudo sed -i 's/^#PUSH_REMOTE=/PUSH_REMOTE="origin"/' /etc/etckeeper/etckeeper.conf
```

設定内容の確認。

```bash
# 使用するバージョン管理システムを指定（デフォルトは git）
VCS="git"

# リモートリポジトリにプッシュする場合は有効にする
PUSH_REMOTE="origin"
```

直接エディタで編集する場合は `sudo vim /etc/etckeeper/etckeeper.conf` を使用できる。

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

### 5.1. 推奨 .gitignore 設定

`/etc` ディレクトリには動的に生成されるファイルや頻繁に変更されるファイルが含まれるため、これらを Git 管理から除外することを推奨する。

以下のコマンドで推奨の `.gitignore` ファイルを作成する。

```bash
sudo tee /etc/.gitignore > /dev/null << 'EOF'
# ログファイル
*.log
*.log.*
/var/log/*

# 一時ファイル
*.tmp
*.temp
/tmp/*

# ランタイム状態ファイル
/machine-id
/hostname

# NetworkManager関連の動的ファイル（接続設定は保持）
/NetworkManager/timestamps
/NetworkManager/NetworkManager.state

# systemd関連の動的ファイル
/systemd/system/*.wants/*
/systemd/user/*.wants/*

# SSL証明書の動的ファイル
/ssl/certs/ca-certificates.crt
/ssl/private/*

# アプリケーション固有の動的設定
/alternatives/*
/apparmor.d/cache/*
/ca-certificates.conf.dpkg*
/chatscript/options.dpkg*
/cron.d/.placeholder

# CUPS関連（動的生成されるため除外）
/cups/printers.conf*
/cups/classes.conf*

# パッケージマネージャーの一時ファイル
/apt/apt.conf.d/*~
/apt/preferences.d/*~
/dpkg/dpkg.cfg.d/*~

# 認証関連の機密ファイル（必要に応じて調整）
/shadow*
/gshadow*
/sudoers.d/README
EOF
```

直接エディタで編集する場合は `sudo vim /etc/.gitignore` を使用できる。

### 6. 初期コミットとプッシュ

初期コミットを作成し、リモートリポジトリにプッシュする。

```bash
sudo git add -A
sudo etckeeper commit -m "first commit"
sudo git push --set-upstream origin master
```

### 7. 自動プッシュの設定

毎日自動的にリモートリポジトリにプッシュするため、`/etc/etckeeper/daily` にプッシュコマンドを追加する。

```bash
echo "git push -u origin master" | sudo tee -a /etc/etckeeper/daily
```

設定を確認する。

```bash
sudo cat /etc/etckeeper/daily
```

直接エディタで編集する場合は `sudo vim /etc/etckeeper/daily` を使用できる。

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