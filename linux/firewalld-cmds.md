# firewalldのコマンドめも

[firewall-cmdコマンドの使い方 - Qiita](https://qiita.com/hana_shin/items/bd9ba363ba06882e1fab)

すべて永続反映

## 数値ポート

### 許可ポート一覧の表示

```bash
sudo firewall-cmd --list-ports --permanent
```

### TCPの80番ポートを許可する

```bash
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports --permanent
```

### TCPの80番ポートの許可を外す

```bash
sudo firewall-cmd --remove-port=80/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports --permanent
```

## サービス

`/etc/services` で定義されているサービス

### 許可サービス一覧を表示

```bash
sudo firewall-cmd --list-services --permanent
```

### サービスで許可する

```bash
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-services --permanent
```

### サービスの許可を外す

```bash
sudo firewall-cmd --remove-service=http --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-services --permanent
```
