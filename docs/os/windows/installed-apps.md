# インストールしているソフトメモ

Windows 10 環境でインストールしているソフトのメモ。カテゴライズは適当。

winget のインストールコマンドは Scoop の main か extras, versions bucket にない場合のみ表記。

## General

一般的な Windows 利用者でも使えるようなソフト群

### 7-Zip

圧縮・展開ソフト

Windows のエクスプローラにも圧縮・展開機能はあるが、動作速度や形式種類数で利用。

- Web サイト: https://sevenzip.osdn.jp
- Scoop: `scoop install 7zip` (main bucket)

### Authy

二段階認証（2FA）でのワンタイムパスワード（OTP）の表示ソフト

Windows だけでなく iOS や Android にもあり、これらを Authy アカウントを用いて同期できる。認証作業時にわざわざスマートフォンを出さなくてもよいし、Google Authenticator みたいにスマートフォン移行の時に全部再生成したりしなくて良いので楽ちん。  
日本語対応はしていないが、そもそもきちんと読まなきゃならない文章もそんなに出てこない。

- Web サイト: https://authy.com/
- Scoop: `scoop install authy` (extras bucket)
- iOS: https://apps.apple.com/jp/app/id494168017
- Android get: https://play.google.com/store/apps/details?id=com.authy.authy

### CubePDF

Windows の印刷機能から PDF 出力したりするソフト（仮想プリンター）

最近のソフトは独自で PDF 出力機能を持っていたりするが、CubePDF の場合は出力形式として PDF だけでなく JPEG やら PNG やらを選べるので利用

- Web サイト: https://www.cube-soft.jp/cubepdf/
- winget: `winget install CubeSoft.CubePDF`

### DaVinci Resolve

無料で多機能の動画編集ソフト

- Web サイト: https://www.blackmagicdesign.com/jp/products/davinciresolve
- Sccop/winget: N/A

### EarTrumpet

ソフトごとの音量をタスクトレイから簡単に変更できるソフト

- Web サイト: https://eartrumpet.app
- Scoop: `scoop install earthumpet` (extras bucket)
- GitHub: https://github.com/File-New-Project/EarTrumpet

### Everything

高速でファイル検索可能なソフト

- Web サイト: https://www.voidtools.com
- Scoop: `scoop install everything` (extras bucket)

### ManicTime

ソフトの利用時間などを記録し、一覧表示できるソフト

- Web サイト: https://www.manictime.com/
- Scoop: `scoop install manictime` (extras bucket)

### paint.net

画像編集ソフト

Windows Store で入れると有料だが、インストーラで入れれば無料

- Web サイト: https://www.getpaint.net
- Scoop: `scoop install paint.net` (extras bucket)

### Power Automate

作業自動化（RPA）ソフト

- Web サイト: https://powerautomate.microsoft.com
- winget: `winget install Microsoft.PowerAutomateDesktop`

### PowerToys

作業効率化機能を複数持ったユーティリティソフト

- GitHub: https://github.com/microsoft/PowerToys
- Scoop: `scoop install powertoys` (extras bucket)

### Pushbullet

PC とスマートフォンやタブレット間でテキストデータやファイルを共有、スマートフォンの通知を PC 上で確認できるソフト

- Web サイト: https://www.pushbullet.com
- winget: `winget install Pushbullet.Pushbullet`
- Android: https://play.google.com/store/apps/details?id=com.pushbullet.android

### ScreenToGif

画面キャプチャ & GIF 保存・編集ソフト

- Web サイト: https://www.screentogif.com
- Scoop: `scoop install screentogif` (extras bucket)

### Vieas

画像表示ソフト

無駄な UI がなく動作が軽快なのを探して利用している。

- Web サイト: https://www.vieas.com/software/vieas.html
- Scoop: `scoop install vieas` (extras bucket)

### 最前面でポーズ

特定のキー（デフォルトは Pause キー）でウィンドウを最前面に固定するソフト

- Vector: https://www.vector.co.jp/soft/winnt/util/se468861.html
- Scoop/winget: N/A

## Advanced

ちょっと上級者向けのソフト群

### CPU-Z

ハードウェア情報表示ソフト

- Web サイト: https://www.cpuid.com/softwares/cpu-z.html
- Scoop: `scoop install cpu-z` (extras bucket)

### Discord PTB/Canary

Discord の開発版ソフト（パブリックテストビルド）

Discord 安定版（Stable）とプロファイルを共有しないので、Stable, PTB, Canary で最大 3 アカウントを同時に利用可能。ただし、ベータ版なので不具合などがある可能性も。  
Scoop でインストールできるが、Discord 側にある自動アップデート機能が走って Scoop でのバージョン管理が壊れるのでインストーラでインストールしたほうが良い。

- PTB ダウンロードページ: https://discord.com/api/downloads/distributions/app/installers/latest?channel=ptb&platform=win&arch=x86
- Canary ダウンロードページ: https://discord.com/api/downloads/distributions/app/installers/latest?channel=canary&platform=win&arch=x86
- Scoop: `scoop install discord-ptb`, `scoop install discord-canary` (versions bucket)

### DiskInfo

### Display Off Soft

### FFmpeg

### HiMacroEx

### HWMonitor

### JQuake

### MediaInfo

### Mouse without Borders

### MP3Gain

### Mp3tag

### nWOL

### Open Hardware Monitor

### OutPlayed

### PreMiD

### ShareX

### SikuliX

### spacedesk

### VoiceMeeter

### Yamaha SyncRoom

### ウィンドウ位置記憶プログラム (VbWinPos)

### プログラムの追加と削除 一覧出力

## Remote Desktop

リモートでデスクトップを操作する遠隔操作系ソフト群

### TeamViewer

### AnyDesk

### Parsec

## Browser Extensions

## Common

Chrome / Firefox 共通の拡張機能

### Adblock

### Augmented Steam

### Better TweetDeck

### Dark Reader

### Eight Dollars

### Enhancer for YouTube

### Form History Control (II)

### I don't care about cookies

### Keepa

### Stylus

### Tab Auto Refresh

### Tampermonkey

### Twitter Stress Reduction

### uBlacklist

### Web Scrobbler

## Firefox

Firefox の拡張機能

### amazon-simple-url

### Black Menu for Google

### Link Cleaner+

### Link to Text Fragment

### Refined GitHub

### SteamDB

### TWP - Translate Web Pages

## Chrome

Chrome の拡張機能

### Amazing Searcher

### Chrome 時計

### DetailedTime

### JSON Viewer

### Kami for Google Chrome

### YouTube デュアル字幕

## Development

主にプログラミング方面の開発関連ソフト群

### DB Browser

### DevToys

### ExecTI

### Gitify

### PuTTY (Pageant)

### Rufus

### Scoop

### SourceTree

### Tera Term

### Termius

### Win32DiskImager

### WinSCP

### Wireshark

### XLaunch
