# Windows 11 OOBE ローカルアカウント作成の新しい回避策

Windows 11 の初期設定（OOBE: Out-of-Box Experience）で Microsoft アカウントの強制作成を回避し、ローカルアカウントを作成するための最新の方法について説明します。

## 背景

従来は `oobe\BypassNRO.cmd` を使用してネットワーク要件をバイパスしていましたが、このファイルが削除されるケースが報告されています。そのため、より確実な新しい回避策が必要となっています。

## 新しい回避策（推奨）

Windows 11 Home 版および Pro 版で利用可能な方法：。

1. ++shift+f10++ でコマンドプロンプトを起動する
2. 以下のコマンドを実行する：
   ```cmd
   start ms-cxh:localonly
   ```

この方法により、Microsoft アカウントの作成を求められることなく、ローカルアカウントの作成画面に直接アクセスできます。

## 従来の方法（BypassNRO.cmd）

`BypassNRO.cmd` が利用可能な場合は、従来の方法も使用できます：。

1. ++shift+f10++ でコマンドプロンプトを起動する
2. `oobe\ByPassNRO.cmd` と入力して実行する（自動で再起動される）
3. LAN ケーブルを抜く（WiFi 接続も無効にする）
4. セットアップを進める
5. ネットワーク接続画面で「インターネットに接続していません」をクリック
6. 「制限された設定で続行」をクリック

## 注意事項

- 新しい方法（`ms-cxh:localonly`）はより確実で、ネットワークの切断も不要
- 従来の方法は `BypassNRO.cmd` ファイルの存在に依存するため、利用できない場合がある
- どちらの方法も Windows 11 Home 版および Pro 版で動作確認済み

## 参考情報

- [X (Twitter) での報告](https://x.com/witherornot1337/status/1906050664741937328)
- 関連 issue: [#515](https://github.com/book000/memo/issues/515)