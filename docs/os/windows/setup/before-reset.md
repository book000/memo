# PCの初期化前に行う作業

## インストール済みアプリケーションのリストアップ

[プログラムの追加と削除 一覧出力](https://forest.watch.impress.co.jp/library/software/pglst/) などを利用して記録を取っておく。  
保存ボタンは CSV 出力。CubePDF などを利用して PDF として出力しておくと良い。

## ハードウェア構成を変える場合

ハードウェアの構成が変わるとライセンスが自動処理されなくなるので、ハードウェアを変更するならば事前に Microsoft アカウントとユーザーを紐づけておくこと。

## WSLのエクスポート

Windows Subsystem for Linux にて Ubuntu などを利用している場合、エクスポートしておくと良い。

`wsl -l -v` で導入中のイメージを確認し、`wsl --export <NAME> <FILENAME>` でエクスポートできる。

参考: https://www.aise.ics.saitama-u.ac.jp/~gotoh/HowToBackupLinuxOnWSL.html

## スクリーンショットの撮影

ショートカットのレイアウトなどは、何かしらでメモをとっておかないとあとあとで困る。  
最低限以下のものはスクリーンショットを撮影（最悪直撮り）し、復元できるようメモをとっておくこと。

- スタートメニュー（Windows キー押して出てくるやつ）
- エクスプローラのサイドバー
- デスクトップ
- タスクバー（隠れているアイコンも）

## ファイルや設定データのバックアップ

もともとの SSD や HDD などのストレージを削除してクリーンインストールするならば、（ストレージのイメージを取るのが望ましいが）最低限、以下はバックアップしておくこと。

- `C:\Program Files`
- `C:\Program Files (x86)`
- `C:\ProgramData`
- `C:\Users\<ユーザ名>\AppData` (`%APPDATA%`, `%LOCALAPPDATA%`)
- ユーザーフォルダにある必要なフォルダ・ファイル（ドキュメントやピクチャフォルダ）

それ以外に、アプリケーションの設定ファイルもバックアップが必要。例えば以下。

- ブラウザのプロファイル（アカウント同期している場合は不要）
- Visual Studio Code のグローバル設定ファイル（`%APPDATA%\Code\User\settings.json`）
- Logicool G HUB のプロファイル（`%LOCALAPPDATA%\LGHUB\settings.db`）
- Thunderbird のプロファイル（`%APPDATA%\Thunderbird\Profiles` & `%APPDATA%\Thunderbird\profiles.ini`）
- AnyDesk のエイリアス設定ファイル（`%ProgramData%\AnyDesk`）
- Minecraft の各種ファイル（`%APPDATA%\.minecraft`）
- Becky の Inbox フォルダ（`C:\Becky!\%USERNAME%\Inbox`）

基本的に、ユーザーフォルダのドキュメントなどは別ストレージに移しておくのがベストだと思っている。  
できるなら C ドライブにファイルを置きすぎないようにする（シンボリックリンクまで張るほどではないとは思っているが…）。

## 確認事項

- デスクトップ背景画像のファイル場所: https://selifelog.com/blog-entry-1555.html
