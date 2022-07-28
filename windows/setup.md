# 自分用 PC セットアップ関連メモ <!-- omit in toc -->

**本メモの内容に起因して、生じたあらゆる損害や障害について一切の責任を負いません。**

クリーンインストール前に `クリーンインストール前にやることメモ` を確認して実施すること。  
`<`, `>` で囲まれたものは置換する必要がある。記載されたコードは原則 PowerShell のコードなので、PowerShell で実行すること。コマンドプロンプトでは動作しない。

Windows 10 Pro 21H2 (Build 19044.1706) にて実施

!! **CSMを切ってSecureBootオンでインストールを実施すること。さもないとBIOSレガシーでWindows10がインストールされる** !!

## クリーンインストール前にやることメモ

- インストール済みアプリケーションのリストアップ
- ハード構成を変える場合は Microsoft アカウントへのログイン
- WSL2 のエクスポート

## 目次 <!-- omit in toc -->

- [具体的な作業内容](#具体的な作業内容)
  - [デバイス名の変更](#デバイス名の変更)
  - [各種ブラウザインストール](#各種ブラウザインストール)
  - [Firefox](#firefox)
  - [Chrome](#chrome)
    - [Opera](#opera)
  - [アンチウィルスソフトのインストール](#アンチウィルスソフトのインストール)
  - [エクスプローラーのカスタマイズ](#エクスプローラーのカスタマイズ)
    - [全般](#全般)
    - [表示](#表示)
  - [ユーザーフォルダの移動](#ユーザーフォルダの移動)
  - [Win10 の標準アプリを削除](#win10-の標準アプリを削除)
  - [OneDrive をエクスプローラーに表示させないようにする](#onedrive-をエクスプローラーに表示させないようにする)
  - [Scoop のインストール・移行](#scoop-のインストール移行)
  - [Pwsh (PowerShell) のインストール](#pwsh-powershell-のインストール)
  - [Win + X 画面の編集](#win--x-画面の編集)
  - [Starship・HackGenNerd のインストール](#starshiphackgennerd-のインストール)
  - [Logicool G Hub の設定移行](#logicool-g-hub-の設定移行)
  - [その他アプリのインストール](#その他アプリのインストール)
  - [スタートアップの設定](#スタートアップの設定)
  - [仮想系のセットアップ](#仮想系のセットアップ)
    - [Windows SandBox](#windows-sandbox)
    - [WSL2](#wsl2)
    - [Docker Desktop](#docker-desktop)
    - [BlueStacks](#bluestacks)
  - [その他利便性向上のための設定](#その他利便性向上のための設定)

## 具体的な作業内容

### デバイス名の変更

`SystemPropertiesComputerName.exe` からデバイス名とワークグループ名を変更できる。  
変更後は再起動が必要で、デバイス名は Firefox が利用するので最初にやったほうがいい。

コマンドラインからも変更可能。管理者権限で PowerShell を開いて以下を実行。

```powershell
wmic computersystem where name="%computername%" call rename name="<COMPUTER-NAME>"
wmic computersystem where name="%computername%" call joindomainorworkgroup name="<WORKSPACE-NAME>"
```

### 各種ブラウザインストール

モニタごとにブラウザをおいているので、3 つのブラウザ（Firefox・Chrome・Opera）をインストールする。

### Firefox

メインブラウザとして利用する。  
拡張機能などの同期は Firefox アカウントで行う

- [公式サイト](https://www.mozilla.org/ja/firefox/new/)
- [ダウンロードリンク](https://www.mozilla.org/ja/firefox/download/thanks/)
- `winget install Mozilla.Firefox`

### Chrome

サブブラウザとして利用する。  
拡張機能などの同期は Google アカウントで行う

- [公式サイト](https://www.google.com/intl/ja_jp/chrome/)
- [ダウンロードリンク](https://www.google.com/intl/ja_jp/chrome/thank-you.html?statcb=0)
- `winget install Google.Chrome`

#### Opera

YouTube などで動画を見たり音楽を聞いたり、TwitterDeck を眺めるために使う。  
拡張機能などの同期は行わない。（Chrome 拡張機能を入れているので壊れそう…）

インストールする拡張機能は以下の通り

- [Install Chrome Extensions](https://addons.opera.com/ja/extensions/details/install-chrome-extensions/)
- [Better TweetDeck](https://chrome.google.com/webstore/detail/better-tweetdeck/micblkellenpbfapmcpcfhcoeohhnpob?hl=ja)
- [Enhancer for YouTube™](https://chrome.google.com/webstore/detail/enhancer-for-youtube/ponfpcnoihfmfllpaingbgckeeldkhle?hl=ja)
- [YouTube™ デュアル字幕](https://chrome.google.com/webstore/detail/youtube-dual-subtitles/hkbdddpiemdeibjoknnofflfgbgnebcm)
- [YouTube NonStop](https://chrome.google.com/webstore/detail/youtube-nonstop/nlkaejmjacpillmajjnopmpbkbnocid)
- [DetailedTime](https://chrome.google.com/webstore/detail/detailedtime/ppgpbdnncfccljjkgfednccihjbakahd?hl=ja)
- [PreMiD](https://chrome.google.com/webstore/detail/premid/agjnjboanicjcpenljmaaigopkgdnihi)
- [Web Scrobbler](https://chrome.google.com/webstore/detail/web-scrobbler/hhinaapppaileiechjoiifaancjggfjm)
- Todoist sidebar(Unofficial): 非公開になってしまったっぽいので、開発者モードからインストールする。

### アンチウィルスソフトのインストール

お好みで。だいたい [Avast](https://www.avast.co.jp/) を入れてる。  
インストール後は以下の設定をしておく。

- `一般` -> `トラブルシューティング` -> `コンポーネントを追加または編集` に進み、 「ソフトウェアアップデーター」「Wi-Fi の検査」「サイレントモード」を削除する
- `プロテクション` -> `メイン シールド` -> (下にスクロールして) `メールシールド` -> `送信するメールの末尾に署名を追加` のチェックを外す

### エクスプローラーのカスタマイズ

エクスプローラーを開き、上部「表示」から「オプション」を開く。

#### 全般

- エクスプローラーで開く: `PC`
- プライバシー
  - [ ] 最近使ったファイルをクイック アクセスに表示する
  - [ ] よく使うフォルダーをクイック アクセスに表示する

#### 表示

- ファイルおよびフォルダー
  - ファイルとフォルダーの表示
    - [x] 隠しファイル、隠しフォルダー、および隠しファイルを表示する
  - [ ] 登録されている拡張子は表示しない

---

タスクバーのカスタマイズも行う。それぞれタスクバーを右クリックして

- 検索 (H)
  - [x] 表示しない
- ニュースと関心事項 (N)
  - [x] 無効にする
- [ ] タスクビュー ボタンを表示(V)
- [ ] タスク バーに People を表示する(P)
- [ ] Windows lnk ワークスペース ボタンを表示(W)

を行っておく。

### ユーザーフォルダの移動

GUI から変更する場合は、ユーザーフォルダを開きひとつずつ `プロパティ` -> `場所` -> アドレスを変更 -> `OK` -> `移動` でできる。

<details>
<summary>コマンドラインからやりたい場合</summary>

以下のレジストリをいじることで[変更できる](https://www.inasoft.org/webhelp/rnsf7/HLP000209.html)らしい。

- `HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders`
- `HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders`

`User Shell Folders` のほうが `Shell Folders` よりも優先されるので、とりあえずそちらだけいじればよさそう。

```powershell
$env:NEW_USER_DIR = "<USER_DIR>"
mkdir $env:NEW_USER_DIR

# フォルダの移動
Move-Item -Force -Path "$env:USERPROFILE\3D Objects" -Destination "$env:NEW_USER_DIR\3D Objects" # 3D オブジェクト
Move-Item -Force -Path "$env:USERPROFILE\Contacts" -Destination "$env:NEW_USER_DIR\Contacts" # アドレス帳
Move-Item -Force -Path "$env:USERPROFILE\Favorites" -Destination "$env:NEW_USER_DIR\Favorites" # お気に入り
Move-Item -Force -Path "$env:USERPROFILE\Downloads" -Destination "$env:NEW_USER_DIR\Downloads" # ダウンロード
Move-Item -Force -Path "$env:USERPROFILE\Desktop" -Destination "$env:NEW_USER_DIR\Desktop" # デスクトップ
Move-Item -Force -Path "$env:USERPROFILE\Documents" -Destination "$env:NEW_USER_DIR\Documents" # ドキュメント
Move-Item -Force -Path "$env:USERPROFILE\Pictures" -Destination "$env:NEW_USER_DIR\Pictures" # ピクチャ
Move-Item -Force -Path "$env:USERPROFILE\Videos" -Destination "$env:NEW_USER_DIR\Videos" # ビデオ
Move-Item -Force -Path "$env:USERPROFILE\Music" -Destination "$env:NEW_USER_DIR\Music" # ミュージック
Move-Item -Force -Path "$env:USERPROFILE\Links" -Destination "$env:NEW_USER_DIR\Links" # リンク
Move-Item -Force -Path "$env:USERPROFILE\Searches" -Destination "$env:NEW_USER_DIR\Searches" # 検索
Move-Item -Force -Path "$env:USERPROFILE\Saved Games" -Destination "$env:NEW_USER_DIR\Saved Games" # 保存したゲーム

# レジストリの編集
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{31C0DD25-9439-4F12-BF41-7FF4EDA38722}" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\3D Objects" /f  # 3D オブジェクト
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{56784854-C6CB-462B-8169-88E350ACB882}" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Contacts" /f  # アドレス帳
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Favorites" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Favorites" /f  # お気に入り
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{374DE290-123F-4565-9164-39C4925E467B}" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Favorites" /f  # ダウンロード
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Desktop" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Desktop" /f  # デスクトップ
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "Personal" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Documents" /f  # ドキュメント
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "My Pictures" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Pictures" /f  # ピクチャ
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "My Video" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Videos" /f  # ビデオ
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "My Music" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Music" /f  # ミュージック
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Links" /f  # リンク
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Searches" /f  # 検索
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v "{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}" /t REG_EXPAND_SZ /d "$env:NEW_USER_DIR\Saved Games" /f  # 保存したゲーム

taskkill /IM explorer.exe /F
explorer.exe
```

</details>

### Win10 の標準アプリを削除

[Windows10 の標準アプリをまとめてアンインストール(削除)する方法#まとめて消す（上記のものを一括削除）](https://ygkb.jp/471#まとめて消す-上記のものを一括削除) を参考に、PowerShell で一括アンインストールを行う。  
ただし、この作業だけでは消えないものもあるのでスタートメニューから必要に応じて削除  
ここで消してしまっても Microsoft Store からインストール可能

<details>
<summary>PowerShellコード引用</summary>

```powershell
# Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage             # 3Dビューアー (1809以降)
Get-AppxPackage king.com.CandyCrushFriends | Remove-AppxPackage              # Candy Crush Friends
Get-AppxPackage Microsoft.549981C3F5F10 | Remove-AppxPackage                 # Cortana (20H1以降)
Get-AppxPackage king.com.FarmHeroesSaga | Remove-AppxPackage                 # Farm Heroes Saga
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage                     # Groove ミュージック
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage  # Microsoft Solitaire Collection
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage           # Mixed Realityポータル
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage            # Office
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage                # OneNote
Get-AppxPackage Microsoft.People | Remove-AppxPackage                        # People
# Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage                       # Print3D (1709以降)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage                      # Skype
Get-AppxPackage SpotifyAB.SpotifyMusic | Remove-AppxPackage                  # Spotify (1709以降)
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage             # Xbox Game Bar (1809以降)
Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage                     # Xbox Live (1809以降)
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage                       # Xbox 本体コンパニオン (1607以降)
Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage               # Xbox その他 (1607以降)
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage          # Xbox その他 (1607以降)
Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage       # Xbox その他 (1607以降)
# Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage                 # アラーム＆クロック
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage                     # 映画 & テレビ
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage                 # カメラ
# Get-AppxPackage Microsoft.ScreenSketch | Remove-AppxPackage                  # 切り取り & スケッチ (1809以降)
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage                     # スマホ同期
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage                   # 天気
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage                       # 問い合わせ
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage                    # ヒント
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage            # フィードバックHub
# Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage                # フォト
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage          # 付箋
# Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage                       # ペイント3D
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage          # ボイスレコーダー
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage                   # マップ
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage     # メール、カレンダー
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage                     # メッセージング
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage                    # モバイル通信プラン
```

</details>

### OneDrive をエクスプローラーに表示させないようにする

- 参考: [Windows10 エクスプローラーの OneDrive を隠す(表示させない)方法 - パソコンの問題を改善](https://pc-kaizen.com/windows10-hide-explorer-onedrive)

レジストリをいじる必要がある。

Personal は `HKCU\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}` 。大学などの Business 系の OneDrive はよくわからないが `HKCU\SOFTWARE\Classes\CLSID\` の下にあるっぽい。`(既定)` の値を見ながらかなあ。  
`System.IsPinnedToNameSpaceTree` を `0` にすることで表示を削除できる。
  
```powershell
reg add "HKCU\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0
```

エクスプローラーの再起動は不要。

### Scoop のインストール・移行

Scoop を利用している場合はこれのインストールと移行作業も必要。結構めんどくさい…。

インストール先を変更している場合は、インストールの前に環境変数の設定が必要。  
以前から利用していたファイル・フォルダがある場合は Scoop 自体の再インストールは不要

- 参考: [scoop のインストール先を変更する - Qiita](https://qiita.com/eamat/items/c91be7a9eb71a709b32b)

`SCOOP` 環境変数をインストール先に設定してからインストールする。

```powershell
$env:SCOOP = '<SCOOP-DIR>'
[environment]::setEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```

インストール済みのアプリケーションをリストアップして、`apps` フォルダを `apps-old` にリネームし、アプリケーションをリストアする。

```cmd
for /f "delims=;" %i in ('dir /b /ad %SCOOP%\apps') do ( echo scoop install %i>>restore.ps1 )
mv %SCOOP%\apps %SCOOP%\apps-old
powershell -ExecutionPolicy RemoteSigned -File restore.ps1
```

あとは適宜パスを通す。

### Pwsh (PowerShell) のインストール

Windows 10 にデフォルトで入っている PowerShell を使うと `新しいクロスプラットフォームの PowerShell をお試しください` って言われてうざいので、新しい Pwsh を入れておく。

- 参考: [Windows への PowerShell のインストール](https://docs.microsoft.com/ja-jp/powershell/scripting/install/installing-powershell-on-windows)

まずは [ここから](https://www.microsoft.com/p/app-installer/9nblggh4nns1#activetab=pivot:overviewtab) Winget を入れる。  
Winget をいれたら以下のコマンドを実行。

```powershell
winget install Microsoft.PowerShell
```

### Win + X 画面の編集

Pwsh を入れたので Win + X やスタートボタンの右クリックで出るリストを編集しておく。

`WinXMenuEditor` というアプリケーションを使う。[いかにも怪しそうなダウンロードページ](https://winaero.com/download.php?view.21) の `Download link` から `WinXMenuEditorRelease.zip` をダウンロード、展開。`WinXEditor.exe` を実行。  
Pwsh を PowerShell と置き換え。

このいかにも怪しそうなやつを使いたくなければ、`%LOCALAPPDATA%\Microsoft\Windows\WinX` のグループフォルダと `desktop.ini` の編集を頑張るしかないかなあ。

### Starship・HackGenNerd のインストール

Starship 自体は`scoop install starship` でインストールできる。

Starship は Git などのカスタムアイコンを表示するために Nerd Font を利用しているので、対応するフォントをインストールする必要がある。  
ここでは HackGenNerd をインストールする。

[Releases](https://github.com/yuru7/HackGen/releases) から `HackGenNerd_vX.Y.Z.zip` をダウンロード、展開。`HackGenNerd-Regular.ttf`　`HackGenNerdConsole-Regular.ttf` `HackGen35Nerd-Regular.ttf` `HackGen35NerdConsole-Regular.ttf` を入れて Pwsh などのフォント設定を変更しておく。  
この際、`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PowerShell\PowerShell 7 (x64).lnk` はその場では編集できない場合があるので、デスクトップなどにコピーして編集、戻すという形をとったほうがよさそう。

### Logicool G Hub の設定移行

`%LocalAppData%\LGHUB` にある `settings.db` を置換するだけ。

- 参考: [Logicool G HUB のプロファイル設定をインポート/エクスポートする方法 - あかえいログ](https://akaeisan.blog/logicool-g-hub-settings/)

### その他アプリのインストール

- EarTrumpet: 使いにくい Windows の音量ミキサーをタスクバーから操作しやすくする。
- TeamViewer: 遠隔操作アプリケーション
- AnyDesk: こちらも遠隔操作アプリケーション。TeamViewer と違い、有料版を急かしたりすることは少ない（少なくとも利用不可にはしてこない）。`%ProgramData%\AnyDesk` の中身を置き換えることで古いエイリアスを継続して利用可能。 [参考](https://support.anydesk.com/ja/knowledge/anydesk%E3%81%AEid%E3%81%A8%E3%82%A2%E3%83%A9%E3%82%A4%E3%82%A2%E3%82%B9)
- Thunderbird: メーラー。`%APPDATA%Thunderbird\Profiles` のプロファイルの中身（プロファイル名は変更しない）を置き換えれば移行できる。
- XTRM Runtime: VB/VC系のランタイムインストーラー https://forest.watch.impress.co.jp/library/software/xtrmruntime/download_10524.html

### スタートアップの設定

エクスプローラーのアドレス欄に `shell:startup` と打ち込めばアクセスできる。あとはお好きに

### 仮想系のセットアップ

まず、BIOS / UEFI から仮想関連の設定をオンにする必要がある。（ASUS マザボを例とする）参考: [仮想化機能を有効にするための BIOS 設定 - TEKWIND](https://www.tekwind.co.jp/ASU/faq/entry_134.php)

- Intel: `Advanced > CPU Configuration > Intel(R) VirtualizationTechnology > [Enabled]`
- AMD: `Advanced > CPU Configuration >SVM > [Enabled]`

`Windows の機能の有効化または無効化` (`OptionalFeatures.exe`) から、`Hyper-V`、`Linux 用 Windows サブシステム` を有効化し再起動しておく。

#### Windows SandBox

Windows の機能の有効化または無効化で `Windows サンドボックス` を有効化すればスタートメニューに `Windows SandBox` が出てくるはず。

#### WSL2

事前にエクスポートしておいた WSL2 ディストリビューションファイルをインポートする形で移行する。

```powershell
wsl --import <NAME> <DIRECTORY> <FILE> --version 2
```

- `<NAME>`: ディストリビューションの名前を指定。なんでもよし
- `<DIRECTORY>`: インストール先ディレクトリ。`C:\wsl\Ubuntu` など。
- `<FILE>`: エクスポートした tar ファイルを指定。

インポートできたら、ディストリビューションに入って `/etc/wsl.conf` に以下を記述

```ini
[user]
default=<USERNAME>
```

参考:

- [Windows 10/11 で WSL 環境を移行する方法 - TechRacho](https://techracho.bpsinc.jp/morimorihoge/2021_11_26/113804)
- [WSL 上の Linux を C ドライブから移動させる](https://www.aise.ics.saitama-u.ac.jp/~gotoh/HowToReplaceWSL.html)

#### Docker Desktop

こちらも、C ドライブを占有してほしくないので別ドライブにデータを置きたい。

- 参考: [Docker Desktop の ディスク領域 を C ドライブから別のドライブへ移動する方法 - nosubject.io](https://nosubject.io/windowsdocker-desktop-move-disk-image/)

[ダウンロードページ](https://docs.docker.com/desktop/windows/install/) の `Docker Desktop for Windows` からインストーラーをダウンロード。とりあえずまずは純粋にインストールする。  
きちんと起動したらきちんと落とす（普通に閉じるとタスクバーに残る）。

```powershell
$env:WSL_DIR = "<WSL_DIR>"
wsl --export docker-desktop $env:WSL_DIR\docker-desktop.tar
wsl --export docker-desktop-data $env:WSL_DIR\docker-desktop-data.tar

wsl --unregister docker-desktop
wsl --unregister docker-desktop-data

wsl --import docker-desktop $env:WSL_DIR\docker-desktop\ $env:WSL_DIR\docker-desktop.tar
wsl --import docker-desktop $env:WSL_DIR\docker-desktop-data\ $env:WSL_DIR\docker-desktop-data.tar
```

#### BlueStacks

[BlueStacks のトップページ](https://www.bluestacks.com/) から **BlueStacks 5 を** ダウンロードして、インストール先を C ドライブ以外にしたうえでインストールする。  
`BlueStacks_nxt` というフォルダを勝手に作ってくるので、適当に古いやつと置き換えればマルチインスタンスマネージャーから起動できる。BlueStacks の**アプリケーション自体は C ドライブにインストール**される。

BlueStacks X を勝手にインストールしやがったら、Windows のアプリと機能からアンインストールしたうえで [PC から BlueStacks 5 を完全にアンインストールする方法](https://support.bluestacks.com/hc/ja/articles/360057724751) を参考に完全アンインストールを実施したうえで再インストール。

### その他利便性向上のための設定

- PINGに応答するようにする: [Windows10 PCへのpingが通らない - n-Archives.net](https://n-archives.net/software/nwol/articles/how-to-allow-ping-response-in-windows10/)
- Windows + V の有効化
- https://www.teradas.net/archives/20665/
- Windows サウンドなしに変更
- サウンド -> 通信アクティビティの設定
- VSCode Local history の保存先変更
- Microsoft Teams の自動起動停止
- タスクバーでウィンドウを選ぶときに全画面でプレビューされるのを止める [Windows10のタスクバープレビューを非表示にする](https://techback.info/windows10-taskbar-preview-hide/)
