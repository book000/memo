# Ubuntu Setup

## ホスト名の変更

```bash
sudo hostnamectl set-hostname <ホスト名>
```

## IPの固定

[Ubuntu 20.04 LTSで固定IPアドレスの設定 - Qiita](https://qiita.com/zen3/items/757f96cbe522a9ad397d)
[Ubuntu 22.04 LTS:初期設定:ネットワークの設定 - Server World](https://www.server-world.info/query?os=Ubuntu_22.04&p=initial_conf&f=3)

`/etc/netplan/99_config.yaml` を作成し、以下を書き込み

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: false
      dhcp6: false
      addresses: [192.168.0.100/24]
      routes:
        - to: default
          via: 192.168.0.1
      nameservers:
        addresses: [192.168.0.1, 8.8.8.8, 8.8.4.4]
```

`sudo netplan apply` で反映。`ip a` で反映されていることを確認

## ユーザーの作成

[【Ubuntu】useraddとadduserの違い - Qiita](https://qiita.com/kaitoland/items/386ebc94c3efa17bbecb)

`useradd` ではデフォルトだとホームディレクトリが作られない、`adduser` は対話でユーザーを作成できる

```bash
tomachi@TEST:~$ sudo adduser test
Adding user `test' ...
Adding new group `test' (1002) ...
Adding new user `test' (1002) with group `test' ...
Creating home directory `/home/test' ...
Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for test
Enter the new value, or press ENTER for the default
        Full Name []:
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] y
```

`sudo` を使えるようにするなら `usermod -aG sudo test` で sudo グループにユーザーを追加しておく

## SSHの設定

`ed25519` でキーを作って公開鍵認証で接続させる。

- `su test`: 対象ユーザーに切り替え
- `cd`: 対象ユーザーのホームディレクトリに移動
- `mkdir -p .ssh`: `.ssh` ディレクトリ作成
- `chmod 700 .ssh`: `.ssh` ディレクトリを 700（所有者のみ RWX 可）にする
- `ssh-keygen -t ed25519`: キー作成。パスフレーズお好み
- この段階で、パスワード認証か何かでサーバに入って秘密鍵（`~/.ssh/id_ed25519`）を入手
- `mv id_ed25519.pub authorized_keys` or `cat id_ed25519.pub >> authorized_keys`: 公開鍵を登録
- `chmod 600 authorized_keys`: ファイルを 600（所有者のみ RW 可）にする
- `exit`: ユーザーから抜ける

ここまでがユーザーの SSH 関連に関する処理。以降はサーバの SSH 設定

`/etc/ssh/sshd_config` を vim などで開き、以下の箇所を修正

- `#Port 22` → `Port 10000`: sshd のポートを変更する
- `PermitRootLogin yes` → `PermitRootLogin no`: root ユーザーへのログインを拒否する
- `#PubkeyAuthentication yes` → `PubkeyAuthentication yes`: 公開鍵認証での認証を許可する（コメントアウトを外す）
- `PasswordAuthentication yes` → `PasswordAuthentication no`: パスワード認証を拒否する

あとは `systemctl restart sshd` で sshd の再起動、`ufw allow 10000` で sshd のポートを開放。
