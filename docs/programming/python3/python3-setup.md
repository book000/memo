# Python3 Setup for Linux (From source code)

ソースからビルドしてインストールするので、Ubuntu / CentOS 系など、UNIX 系で動くはず。  
Windows は公式のインストーラとか Scoop とか WinGet とかそこらへんでインストールすればよいんじゃないかなあ。

## 1. 最新のバージョンを確認する or インストールしたいバージョンを確認する

[~~見づらい~~ 公式サイトのバージョンリスト](https://www.python.org/downloads/source/) か、[比較的見やすい非公式リンク一覧サイト](https://pythonlinks.python.jp) の「`Source`」を閲覧し、最新のバージョンかインストールしたいバージョンを選んでください。

ここで `tar.gz` や `zip` などのインストーラをダウンロードする必要はありません。

## 2. パッケージマネージャーのパッケージ一覧更新 (APT のみ)

Debian 系（Ubuntu/Debian 等）を使用している場合はパッケージマネージャーは [`apt`](https://ja.wikipedia.org/wiki/APT) ですので、パッケージ一覧の更新をする必要があります。  
以下のコマンドを実行してください。

```bash
sudo apt update
```

Red Hat 系（CentOS や Fedora 等）を使用している場合はパッケージマネージャーは [`yum`](https://ja.wikipedia.org/wiki/Yellowdog_Updater_Modified) ですので、この作業は必要ではありません。

## 3. 必要なパッケージのインストール

どのパッケージが必要かについての情報が微妙ですので、公式サイトなどの情報も参考にしてください。

Debian GNU/Linux 系（APT）: [公式サイト](https://devguide.python.org/setup/#install-dependencies) を参考。

```bash
sudo apt install build-essential gdb lcov libbz2-dev libffi-dev \
      libgdbm-dev liblzma-dev libncurses5-dev libreadline6-dev \
      libsqlite3-dev libssl-dev lzma lzma-dev tk-dev uuid-dev zlib1g-dev
```

Red Hat 系（yum）: [公式サイト](https://devguide.python.org/setup/#install-dependencies) と [非公式リンク一覧サイトの「Python のビルド手順(Unix)」](https://pythonlinks.python.jp/) を参考）

```bash
sudo yum groupinstall "development tools"
sudo yum install bzip2-devel gdbm-devel libffi-devel \
  libuuid-devel ncurses-devel openssl-devel readline-devel \
  sqlite-devel tk-devel wget xz-devel zlib-devel
```

（`yum-utils` をインストールすると、`yum-builddep` を使えるのかも…使ったことがないのでよくわからない）

## 4. Python ソースコードのダウンロード・展開

`<VERSION>` をインストールしたいバージョンに置き換えてください。

```bash
wget https://www.python.org/ftp/python/<VERSION>/Python-<VERSION>.tar.xz
# e.g. wget https://www.python.org/ftp/python/3.9.7/Python-3.9.7.tar.xz
tar xvf Python-<VERSION>.tar.xz
cd Python-<VERSION>.tar.xz
```

[GitHub](https://github.com/python/cpython) からクローンしてソースコードを引っ張ってきても良いです。

## 5. ビルド

以下のコマンドは `/usr/local/` にインストールします。

```bash
./configure --enable-optimizations
make -j4
sudo make install
```

- `make` の `-j4` は CPU コア数ですので、環境に応じて変更してください。
- `./configure` に `--prefix=/path/to/` をつけると、インストール先を変更できます。
- `make install` でなく `make altinstall` をすると、`man` への反映と `/usr/bin/python` のシンボリックリンクが作られなくなるようです。**既存の Python2 環境を破壊したくないなら、`altinstall` を使うべきです。**
- `make` 後に、`The necessary bits to build these optional modules were not found:` というメッセージが出た場合、拡張モジュールに必要な依存関係がなかったためにインストールできなかった拡張モジュールが表示されています。必要な依存関係をインストール後、再度ビルドを実施してください。

## 6. 動作確認

`python --version` を試し、インストールしたバージョンが正しく表示されれば成功です。
