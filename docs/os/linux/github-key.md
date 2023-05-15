# GitHub へのキー登録

Ubuntu 22.04 で公開鍵・秘密鍵ペアを作り GitHub に公開鍵を登録して、リモート操作ができるようにする。  
ED25519 でキーペアを作る。

## 環境

複数環境での動作確認済み。最低でも、OpenSSH 6.5 以降が必要。

| OS                               | ssh                                 | git     |
| :------------------------------- | :---------------------------------- | :------ |
| CentOS 7.8.2003                  | OpenSSH_7.4p1 / OpenSSL 1.0.2k-fips | 1.8.3.1 |
| Raspberry Pi OS 64bit (Bullseye) | OpenSSH_8.4p1 / OpenSSL 1.1.1n      | 2.30.2  |
| Ubuntu 22.04.2 LTS               | OpenSSH_8.9p1 / OpenSSL 3.0.2       | 2.34.1  |

## 前提知識

公開鍵暗号を利用した認証についての理解が必要。  
少なくとも、相手に公開鍵を渡すべきなのか秘密鍵を渡すべきなのかくらいは理解しておかないとダメかなとは思う。

## 作業

同等の内容が [公式ドキュメント](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account?platform=linux) として記載されているが、なかなか微妙。

1. キーペアを作成する
2. SSH 設定ファイルを作成する
3. GitHub に公開鍵を登録する
4. 接続確認を行う

### 1. キーペアを作成する

ED25519 でキーペアを作成するため、以下のコマンドを実行する。  
ここでは、`~/.ssh/github_ed25519` に出力する。

```shell
ssh-keygen -t ed25519 -f ~/.ssh/github_ed25519
# 適宜パスフレーズを入力
```

`cat ~/.ssh/github_ed25519.pub` などで公開鍵を確認し、コピーしておく。

### 2. SSH 設定ファイルを作成する

`~/.ssh/config` を作成し、以下を書き込む。

```text
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/github_ed25519
  User git
```

`github.com` に接続する際にデフォルトで `git` ユーザーと `~/.ssh/github_ed25519` の鍵を利用する。

### 3. GitHub に公開鍵を登録する

1 で作成した公開鍵を GitHub に登録する。

github.com を開き、右上の自分のアイコンをクリック。`Settings` を開く。左側ナビゲーションバーから `SSH and GPG keys` をクリックし、移動後右上 `New SSH key` をクリック。  
または https://github.com/settings/ssh/new に直接アクセスしても良い。

`SSH keys / Add new` ページで、以下を入力する。

- `Title`: お好みで。何も入力しない場合公開鍵の末尾にあるユーザー名とホスト情報が自動的に入る。
- `Key type`: `Authentication Key` を指定
- `Key`: 1 でコピーした公開鍵を貼り付ける。`ssh-ed25519` から始まっていることを確認。

### 4. 接続確認を行う

以下のコマンドを実行し、接続できるかの確認をする。

```shell
ssh -T github.com
```

以下のように出力されたら完了。

```text
Hi book000! You've successfully authenticated, but GitHub does not provide shell access.
```

はじめて接続する場合、フィンガープリントの確認が出てくる。正しいことを [公式ドキュメント](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints) で確認したあと、以下のように `yes` で承認する。（正しいフィンガープリントを打ち込んで Enter でも良いっぽい。その方が適切かも）

```text
The authenticity of host 'github.com (20.27.177.113)' can't be established.
ECDSA key fingerprint is SHA256:p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com,20.27.177.113' (ECDSA) to the list of known hosts.
```
