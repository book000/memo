# Ubuntu Setup

## ホスト名の変更

```bash
sudo hostnamectl set-hostname <ホスト名>
```

## IPの固定

[Ubuntu 20.04 LTSで固定IPアドレスの設定 - Qiita](https://qiita.com/zen3/items/757f96cbe522a9ad397d)

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
      gateway4: 192.168.0.1
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
