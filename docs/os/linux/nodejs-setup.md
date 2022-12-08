# Node.js Setup

参考: [nodesource/distributions/README.md](https://github.com/nodesource/distributions/blob/master/README.md)

## Ubuntu など Debian GNU/Linux 系

### 1. インストールするバージョンを決める

基本は LTS か Latest を使う。何が指定できるかは [リリース一覧](https://nodejs.org/ja/download/releases/) あたりを見るとよいかも

### 2. リポジトリインストールスクリプトを走らせる

まずは、パッケージが入っているリポジトリをパッケージマネージャーにインストールする。ここではとりあえず執筆時点最新の v17 と LTS、最新バージョンをインストールする。

```bash
# v17 リポジトリをインストール
curl -sL https://deb.nodesource.com/setup_17.x | sudo -E bash -
# LTS リポジトリをインストール
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
# 最新バージョンリポジトリをインストール
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
```

### 3. パッケージをインストール

[APT](https://ja.wikipedia.org/wiki/APT) を用いてインストールする。

とりあえずパッケージ一覧の更新をしておく。基本的に上記リポジトリインストール時点で更新されているはずだけど…

```bash
sudo apt update
```

その後、パッケージのインストールを行う

```bash
sudo apt install nodejs
```

インストールしようとしているバージョンであるかどうかを確認してからインストールすること。

### 4. 動作確認

`node -v` を試し、インストールしたバージョンが正しく表示されれば成功。

## CentOS など Red Hat 系

### 1. インストールするバージョンを決める

基本は LTS か Latest を使う。何が指定できるかは [リリース一覧](https://nodejs.org/ja/download/releases/) あたりを見るとよいかも

### 2. リポジトリインストールスクリプトを走らせる

まずは、パッケージが入っているリポジトリをパッケージマネージャーにインストールする。ここではとりあえず執筆時点最新の v17 と LTS、最新バージョンをインストールする。

```bash
# v17 リポジトリをインストール
curl -sL https://rpm.nodesource.com/setup_17.x | sudo -E bash -
# LTS リポジトリをインストール
curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo -E bash -
# 最新バージョンリポジトリをインストール
curl -fsSL https://rpm.nodesource.com/setup_current.x | sudo -E bash -
```

### 3. パッケージをインストール

[YUM](https://ja.wikipedia.org/wiki/Yellowdog_Updater_Modified) を用いてインストールする。

すでに古い Node.js をインストールしている場合、キャッシュが残っていて目当てのバージョンがうまくインストールできないケースがあるので以下を実行しておく

```bash
sudo yum clean all
```

その後、パッケージのインストールを行う

```bash
sudo yum install nodejs
```

インストールしようとしているバージョンであるかどうかを確認してからインストールすること。

### 4. 動作確認

`node -v` を試し、インストールしたバージョンが正しく表示されれば成功。
