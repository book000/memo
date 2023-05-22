# インストールしているソフトメモ

Windows 10 環境でインストールしているソフトのメモ。カテゴライズは適当。

winget のインストールコマンドは Scoop の main か extras, versions bucket にない場合のみ表記。

## General

一般的な Windows 利用者でも使えるようなソフト群。

### 7-Zip

圧縮・展開ソフト。

Windows のエクスプローラにも圧縮・展開機能はあるが、動作速度や形式種類数で利用。

- Web サイト: https://sevenzip.osdn.jp
- Scoop: `scoop install 7zip` (main bucket)

### Authy

二段階認証（2FA）でのワンタイムパスワード（OTP）の表示ソフト。

Windows だけでなく iOS や Android にもあり、これらを Authy アカウントを用いて同期できる。認証作業時にわざわざスマートフォンを出さなくてもよいし、Google Authenticator みたいにスマートフォン移行の時に全部再生成したりしなくて良いので楽ちん。  
日本語対応はしていないが、そもそもきちんと読まなきゃならない文章もそんなに出てこない。

- Web サイト: https://authy.com/
- Scoop: `scoop install authy` (extras bucket)
- iOS: https://apps.apple.com/jp/app/id494168017
- Android get: https://play.google.com/store/apps/details?id=com.authy.authy

### CubePDF

Windows の印刷機能から PDF 出力したりするソフト（仮想プリンター）

最近のソフトは独自で PDF 出力機能を持っていたりするが、CubePDF の場合は出力形式として PDF だけでなく JPEG やら PNG やらを選べるので利用。

- Web サイト: https://www.cube-soft.jp/cubepdf/
- winget: `winget install CubeSoft.CubePDF`

### DaVinci Resolve

無料で多機能の動画編集ソフト。

- Web サイト: https://www.blackmagicdesign.com/jp/products/davinciresolve
- Sccop/winget: N/A

### EarTrumpet

ソフトごとの音量をタスクトレイから簡単に変更できるソフト。

- Web サイト: https://eartrumpet.app
- Scoop: `scoop install eartrumpet` (extras bucket)
- GitHub: https://github.com/File-New-Project/EarTrumpet

### Everything

高速でファイル検索可能なソフト。

- Web サイト: https://www.voidtools.com
- Scoop: `scoop install everything` (extras bucket)

### ManicTime

ソフトの利用時間などを記録し、一覧表示できるソフト。

- Web サイト: https://www.manictime.com/
- Scoop: `scoop install manictime` (extras bucket)

### paint.net

画像編集ソフト。

Windows Store で入れると有料だが、インストーラで入れれば無料。

- Web サイト: https://www.getpaint.net
- Scoop: `scoop install paint.net` (extras bucket)

### Power Automate

作業自動化（RPA）ソフト。

- Web サイト: https://powerautomate.microsoft.com
- winget: `winget install Microsoft.PowerAutomateDesktop`

### PowerToys

作業効率化の機能を複数持ったユーティリティソフト。

- GitHub: https://github.com/microsoft/PowerToys
- Scoop: `scoop install powertoys` (extras bucket)

### Pushbullet

パソコンとスマートフォンやタブレット間でテキストデータやファイルを共有、スマートフォンの通知をパソコン上で確認できるソフト。

- Web サイト: https://www.pushbullet.com
- winget: `winget install Pushbullet.Pushbullet`
- Android: https://play.google.com/store/apps/details?id=com.pushbullet.android

### ScreenToGif

画面キャプチャ & GIF 保存・編集ソフト。

- Web サイト: https://www.screentogif.com
- Scoop: `scoop install screentogif` (extras bucket)

### Vieas

画像表示ソフト。

無駄な UI がなく動作が軽快なのを探して利用している。

- Web サイト: https://www.vieas.com/software/vieas.html
- Scoop: `scoop install vieas` (extras bucket)

### 最前面でポーズ

特定のキー（デフォルトは Pause キー）で画面を最前面に固定するソフト。

- Vector: https://www.vector.co.jp/soft/winnt/util/se468861.html
- Scoop/winget: N/A

## Advanced

ちょっと上級者向けのソフト群。

### CPU-Z

ハードウェア情報表示ソフト。

- Web サイト: https://www.cpuid.com/softwares/cpu-z.html
- Scoop: `scoop install cpu-z` (extras bucket)

### CrystalDiskInfo

S.M.A.R.T. 値などから HDD / SSD の状態確認をするソフト。

- Web サイト: https://crystalmark.info/ja/software/crystaldiskinfo/
- Scoop: `scoop install crystaldiskinfo` (extras bucket)

### Discord PTB/Canary

Discord の開発版ソフト（パブリックテストビルド）

Discord 安定版（Stable）とプロファイルを共有しないので、Stable, PTB, Canary で最大 3 アカウントを同時に利用可能。ただし、ベータ版なので不具合などがある可能性も。  
Scoop でインストールできるが、Discord そばにある自動アップデート機能が走って Scoop でのバージョン管理が壊れるのでインストーラでインストールしたほうが良い。

- PTB ダウンロードページ: https://discord.com/api/downloads/distributions/app/installers/latest?channel=ptb&platform=win&arch=x86
- Canary ダウンロードページ: https://discord.com/api/downloads/distributions/app/installers/latest?channel=canary&platform=win&arch=x86
- Scoop
  - `scoop install discord-ptb` (versions bucket)
  - `scoop install discord-canary` (versions bucket)

### DiskInfo

ストレージ使用状況のチェックソフト。

- Vector: https://www.vector.co.jp/soft/winnt/util/se475617.html
- Scoop/winget: N/A

### Display Off Soft

無操作時にディスプレイの電源を消すソフト。

ゲームとかをしたあとだと Windows のスリープ設定が動かないケースがあるので入れている。

- Vector: https://www.vector.co.jp/soft/winnt/util/se493306.html
- Scoop/winget: N/A

### FFmpeg

動画・音声ファイルの変換とか編集とかいろいろできるコマンドラインソフト。

MP4 から MP3 に変換したいときとか、ネット上の不審なサイトを使わずとも自分のパソコンで変換できる。

- Web サイト: https://ffmpeg.org/
- Scoop: `scoop install ffmpeg` (main bucket)

### HiMacroEx

マウス・キーボード操作を記録・再生するソフト。

Power Automate で作るほどじゃない（特定のボタンが現れたらとかやらない）場合はこっちを使う。

- Vector: https://www.vector.co.jp/soft/winnt/util/se427963.html
- Scoop/winget: N/A

### HWMonitor

ハードウェア状態監視ソフト。

- Web サイト: https://www.cpuid.com/softwares/hwmonitor.html
- Scoop: `scoop install hwmonitor` (extras bucket)

### JQuake

日本国内の地震監視・通知ソフト。

- Web サイト: https://jquake.net
- Scoop: `scoop install jquake` ([book000/scoop-bucket](https://github.com/book000/scoop-bucket) bucket)
- winget: N/A

### MediaInfo

動画・音声ファイルの情報を表示するソフト。

- Web サイト: https://mediaarea.net/en/MediaInfo
- Scoop: `scoop install mediainfo` (main bucket)

### Mouse without Borders

1 つのキーボード・マウスで複数のパソコンを操作するソフト。

- インストールページ: https://www.microsoft.com/en-us/download/details.aspx?id=35460
- winget: `winget install Microsoft.MouseWithoutBorders`

### MP3Gain

MP3 ファイルの音量を音質劣化させず一定化するソフト。

ポータブル版は SourceForge の Files タブから ZIP ファイルを探すか、PortableApps あたりで落とす。

- SourceForge: https://sourceforge.net/projects/mp3gain/
- winget: `winget install GlenSawyer.MP3Gain`

### Mp3tag

MP3 ファイルのメタデータを編集するソフト。

メタデータのデータソースをカスタムできるので、iTunes にあるトラックデータを書き込むこともできる。[参考](https://www.nihongoka.com/mp3tag/mp3tag_itunes/)

- Web サイト: https://www.mp3tag.de
- Scoop: `scoop install mp3tag` (extras bucket)

### nWOL

Wake On LAN のマジックパケットを送信するソフト。

- Web サイト: https://n-archives.net/software/nwol/
- Scoop/winget: N/A

### Open Hardware Monitor

ハードウェア状態監視ソフト。

- Web サイト: https://openhardwaremonitor.org/
- Scoop/winget: N/A

### OutPlayed

ゲームプレイを自動でキャプチャするソフト。

[Overwolf](https://www.overwolf.com/) のサブアプリケーション扱いなので、Overwolf をインストールしてからインストールする必要がある。

- Web サイト: https://go.overwolf.com/outplayed/
- Scoop/winget: N/A

winget、`Overwolf.CurseForge` はあるのか…。

### PreMiD

ブラウザでの作業を Discord のプロフィール (Discord Rich Presence) に表示するソフト。

YouTube や Amazon Music で再生している曲とか Google で検索しているモノとか。  
このソフトを Windows にインストールするのに加えて、利用しているブラウザに拡張機能をインストールする必要がある。

- Web サイト: https://premid.app
- Scoop/winget: N/A（Microsoft Store 版は winget にある）
- Chrome: https://chrome.google.com/webstore/detail/agjnjboanicjcpenljmaaigopkgdnihi
- Firefox: ストアにはないので、[こちら](https://docs.premid.app/en/install/firefox) を参考に導入
- GitHub: https://github.com/PreMiD/PreMiD

### ShareX

画面キャプチャ & Imgur などへのアップロード、その他ユーティリティソフト。

- Web サイト: https://getsharex.com/
- Scoop: `scoop install sharex` (extras bucket)
- GitHub: https://github.com/ShareX/ShareX

### SikuliX

作業自動化（RPA）ソフト。

Jython などで書ける RPA ソフトなので、成果物を Git 管理できたりする。jar ファイルで配布されているので、Java 環境が必要。

- Web サイト: http://sikulix.com or https://sikulix.github.io
- ダウンロードページ: https://raiman.github.io/SikuliX1/downloads.html
- GitHub: https://github.com/RaiMan/SikuliX1

### spacedesk

スマートフォンやタブレットをパソコンの拡張ディスプレイとして使えるソフト。

- Web サイト: https://www.spacedesk.net/
- winget: `winget install Datronicsoft.SpacedeskDriver.Server`
- iOS: https://itunes.apple.com/us/app/id1069217220
- Android: https://play.google.com/store/apps/details?id=ph.spacedesk.beta

### Voicemeeter

仮想オーディオミキサーソフト。

仮想オーディオデバイスとして `VoiceMeeter Input/Output`, `VoiceMeeter Aux Input/Output` の 2 つが追加される。それぞれ Input に入力された音声は Output デバイスで聴くことができるので、いろいろ活用できる。

- Web サイト: https://vb-audio.com/Voicemeeter/
- winget: `winget install VB-Audio.Voicemeeter`

### Yamaha SYNCROOM

リモート音楽セッションソフト。

これも Voicemeeter 同様に仮想オーディオデバイスとして `Yamaha SYNCROOM Driver` が追加される。

- Web サイト: https://syncroom.yamaha.com
- Scoop/winget: N/A

### 画面位置記憶プログラム (VbWinPos)

特定画面の位置を記憶し、位置合わせを行うソフト。

- Web サイト: https://www.vector.co.jp/soft/win95/util/se401241.html
- Scoop/winget: N/A

### プログラムの追加と削除 一覧出力

Windows の「プログラムの追加と削除」のように、パソコンにインストールされているソフトの一覧表示と CSV 出力・印刷を行えるソフト。

- Web サイト: http://www.office-neo.jp/pglst/pglst.html
- Scoop/winget: N/A

## Remote Desktop

リモートでデスクトップを操作する遠隔操作系ソフト群。

### TeamViewer

利用頻度にもよるのだろうとは思うが、かなりの頻度で商用利用と誤認されて使えなくなることがある。  
しかしほかのソフトに比べてキー入力やマウス操作の面で安定はしている。

- Web サイト: https://www.teamviewer.com

### AnyDesk

TeamViewer がつながらない場合の逃げとして利用。マウス操作にはそこまで文句はないのだが、IME の切り替えがうまくいかないことがある。  
エイリアスとして覚えやすい名前をつけられる。

- Web サイト: https://anydesk.com

### Parsec

ゲームプレイ向けのリモートデスクトップソフト。FF14 をプレイするために利用。  
TeamViewer や AnyDesk ではキーの長押しがうまく動作しない問題があったりなどゲームプレイには向いていない。

## Browser Extensions

ブラウザの拡張機能。

## Common

Chrome / Firefox 共通の拡張機能。

### Adblock

言わずと知れた広告ブロック。

- Web サイト: https://getadblock.com
- Chrome: https://chrome.google.com/webstore/detail/gighmmpiobklfepjocnamgkkbiglidom
- Firefox: https://addons.mozilla.org/firefox/addon/adblock-for-firefox/

### Augmented Steam

Steam のゲームページにそのゲームに関する情報を追加で表示したりする。

- Web サイト: https://augmentedsteam.com/
- Chrome: https://chrome.google.com/webstore/detail/dnhpnfgdlenaccegplpojghhmaamnnfp
- Firefox: https://addons.mozilla.org/ja/firefox/addon/augmented-steam/

### Better TweetDeck

TweetDeck をさらに使いやすくする。

- Web サイト: https://better.tw/
- Chrome: https://chrome.google.com/webstore/detail/micblkellenpbfapmcpcfhcoeohhnpob
- Firefox: https://addons.mozilla.org/ja/firefox/addon/better-tweetdeck-17/

### Dark Reader

ダークモード非対応のページでもダークモードにする。

正直使いやすいかは微妙。入れといて無効にしている。

- Chrome: https://chrome.google.com/webstore/detail/eimadpbcbfnmbkopoojfekhnkhdbieeh
- Firefox: https://addons.mozilla.org/ja/firefox/addon/darkreader/

### Eight Dollars

Twitter の認証済みバッチが従来の認証によって追加されたのか、Twitter Blue によって追加されたのかを見やすく表示する。

- Chrome: https://chrome.google.com/webstore/detail/fjbponfbognnefnmbffcfllkibbbobki
- Firefox: https://addons.mozilla.org/ja/firefox/addon/eightdollars/
- GitHub: https://github.com/wseagar/eight-dollars

### Enhancer for YouTube

YouTube を使いやすくするやつ。

- Web サイト: https://www.mrfdev.com/enhancer-for-youtube
- Chrome: https://chrome.google.com/webstore/detail/ponfpcnoihfmfllpaingbgckeeldkhle
- Firefox: https://addons.mozilla.org/ja/firefox/addon/enhancer-for-youtube/

### Form History Control (II)

フォームに追加した文字列をバックアップ（履歴として保持）しておける。

- Chrome: https://chrome.google.com/webstore/detail/lpcccgcdjibejkgiaeijbmkpbnbkglkb
- Firefox: https://addons.mozilla.org/ja/firefox/addon/form-history-control/

### I don't care about cookies

Cookie に関する警告を消す。

- Web サイト: https://www.i-dont-care-about-cookies.eu
- Chrome: https://chrome.google.com/webstore/detail/fihnjjcciajhdojfnbdddfaoknhalnja
- Firefox: https://addons.mozilla.org/ja/firefox/addon/i-dont-care-about-cookies/

### Keepa

Amazon の値段推移をグラフで見る。

- Web サイト: https://keepa.com
- Chrome: https://chrome.google.com/webstore/detail/neebplgakaahbhdphmkckjjcegoiijjo?hl=ja
- Firefox: https://addons.mozilla.org/ja/firefox/addon/keepa/

### Refined GitHub

GitHub を使いやすくするやつ。

- Chrome: https://chrome.google.com/webstore/detail/hlepfoohegkhhmjieoechaddaejaokhf
- Firefox: https://addons.mozilla.org/ja/firefox/addon/refined-github-/
- GitHub: https://github.com/refined-github/refined-github

### SteamDB

SteamDB の情報を Steam のゲームページに表示する。

- Web サイト: https://steamdb.info
- Chrome: https://chrome.google.com/webstore/detail/kdbmhfkmnlmbkgbabkdealhhbfhlmmon
- Firefox: https://addons.mozilla.org/firefox/addon/steam-database/

### Stylus

特定の Web ページにカスタム CSS を適用する。

- Web サイト: https://add0n.com/stylus.html
- Chrome: https://chrome.google.com/webstore/detail/clngdbkpkpeebahjckkjfobafhncgmne
- Firefox: https://addons.mozilla.org/ja/firefox/addon/styl-us/
- GitHub: https://github.com/openstyles/stylus

### Tab Auto Refresh

Web ページを特定のインターバルで自動更新する。

- Web サイト: https://mybrowseraddon.com/tab-auto-refresh.html
- Chrome: https://chrome.google.com/webstore/detail/jaioibhbkffompljnnipmpkeafhpicpd
- Firefox: https://addons.mozilla.org/ja/firefox/addon/tab-auto-refresh/

### Tampermonkey

特定の Web ページにカスタム JavaScript を適用する。

- Web サイト: https://www.tampermonkey.net
- Chrome: https://chrome.google.com/webstore/detail/dhdgffkkebhmkfjojejmpbldmpobfkfo
- Firefox: https://addons.mozilla.org/ja/firefox/addon/tampermonkey/

### Twitter Stress Reduction

Twitter で特定の文字列を含むツイートやトレンドを非表示にする。

- Web サイト: https://shirouzu.jp/tech/twitter-stress-reduction
- Chrome: https://chrome.google.com/webstore/detail/ipnjgahnocpaefhffbnnjonihlihoeic
- Firefox: https://addons.mozilla.org/ja/firefox/addon/twitter-stress-reduction/

### uBlacklist

Google の検索結果から特定ドメインの検索結果を非表示にする。

- Chrome: https://chrome.google.com/webstore/detail/pncfbmialoiaghdehhbnbhkkgmjanfhe
- Firefox: https://addons.mozilla.org/ja/firefox/addon/ublacklist/

### Web Scrobbler

YouTube などで聴いている曲を Last.fm などの Scrobble サービスに Scrobble する。

- Web サイト: https://web-scrobbler.com/
- Chrome: https://chrome.google.com/webstore/detail/hhinaapppaileiechjoiifaancjggfjm
- Firefox: https://addons.mozilla.org/ja/firefox/addon/web-scrobbler/
- GitHub: https://github.com/web-scrobbler/web-scrobbler

## Firefox

Firefox の拡張機能。

### Black Menu for Google

ドロップダウンリストから Google サービスにアクセスできる。

- Web サイト: https://apps.jeurissen.co/black-menu-for-google
- Firefox: https://addons.mozilla.org/ja/firefox/addon/black-menu-google/

### Link Cleaner+

[UTM parameters](https://en.wikipedia.org/wiki/UTM_parameters) などの追跡パラメータや Amazon のめちゃくちゃ長い URL を短いものに置き換える。

- Firefox: https://addons.mozilla.org/ja/firefox/addon/link-cleaner-plus/
- GitHub: https://github.com/apiraino/link_cleaner

### Link to Text Fragment

選択しているテキストの [Text Fragment](https://wicg.github.io/scroll-to-text-fragment/) URL をコピーしたり、Text Fragment 付きの URL にアクセスしたときにハイライトする。

Chrome の場合はこの機能がビルトインされている。

- Firefox: https://addons.mozilla.org/ja/firefox/addon/link-to-text-fragment/
- GitHub: https://github.com/GoogleChromeLabs/link-to-text-fragment

### TWP - Translate Web Pages

Web ページを翻訳する。

- Firefox: https://addons.mozilla.org/ja/firefox/addon/traduzir-paginas-web/
- GitHub: https://github.com/FilipePS/Traduzir-paginas-web

## Chrome

Chrome の拡張機能。

### Amazing Searcher

Google 検索結果の右側に対象期間や言語などをカスタムできるリンク群を表示する。

- Chrome: https://chrome.google.com/webstore/detail/amazing-searcher/poheekmlppakdboaalpmhfpbmnefeokj
- GitHub: https://github.com/eetann/amazing-searcher

### Chrome 時計

ブラウザツールバーに時刻を表示する & 毎時 0 時に現在時刻の通知を出す。

- Chrome: https://chrome.google.com/webstore/detail/icegcmhgphfkgglbljbkdegiaaihifce
- GitHub: https://github.com/derek1906/CoolClock

### DetailedTime

YouTube 動画・ライブの具体的な投稿日時を表示する。

- Chrome: https://chrome.google.com/webstore/detail/ppgpbdnncfccljjkgfednccihjbakahd

### JSON Viewer

JSON をフォーマットして表示する。

- Chrome: https://chrome.google.com/webstore/detail/gbmdgpbipfallnflgajpaliibnhdgobh
- GitHub: https://github.com/tulios/json-viewer

### YouTube デュアル字幕

YouTube で複数言語の字幕を表示する。

- Chrome: https://chrome.google.com/webstore/detail/hkbdddpiemdeibjoknnofflfgbgnebcm

## Development

主にプログラミング方面の開発関連ソフト群。

### DB Browser for SQLite

SQLite ファイルをブラウジングするソフト。

- Web サイト: https://sqlitebrowser.org/
- Scoop: `scoop install sqlitebrowser` (extras bucket)

### DevToys

開発者向けの十徳ナイフソフト。JSON と YAML の相互変換とか。

- Web サイト: https://devtoys.app/
- winget: `winget install DevToys`（Microsoft Store で提供）
- GitHub: https://github.com/veler/DevToys

### GitHub Desktop

GitHub のデスクトップソフト。

- Web サイト: https://desktop.github.com/
- Scoop: `scoop install github` (extras bucket)
- GitHub: https://github.com/desktop/desktop

### Gitify

GitHub の通知を Windows で通知するソフト。

あんまりメンテナンスされていないので、別のソフトを探した方がよいかも。

- Web サイト: https://www.gitify.io
- Scoop: `scoop install gitify` (extras bucket)
- GitHub: https://github.com/manosim/gitify/

### Rufus

ISO ファイルを USB メモリなどに書き込むソフト。

- Web サイト: https://rufus.ie
- Scoop: `scoop install rufus` (extras bucket)
- GitHub: https://github.com/pbatard/rufus

### Scoop

Windows パッケージ管理ソフト。

- Web サイト: https://scoop.sh
- GitHub: https://github.com/ScoopInstaller/Scoop

### SourceTree

Git GUI クライアントソフト。

- Web サイト: https://www.sourcetreeapp.com
- Scoop: `scoop install sourcetree` (extras bucket)

### Tera Term

SSH / Telnet / Serial クライアントソフト。

- Web サイト: https://ttssh2.osdn.jp
- Scoop: `scoop install teraterm` (extras bucket)

### Termius

SSH クライアントソフト。

Windows だけでなく、iOS や Android でも利用できる。接続設定も同期される。

- Web サイト: https://termius.com
- Scoop: `scoop install termius` (extras bucket)
- iOS: https://apps.apple.com/us/app/id549039908
- Android: https://play.google.com/store/apps/details?id=com.server.auditor.ssh.client

### Win32DiskImager / Win32DiskImagerRenewal

イメージファイルを書き込んだり書き出したりするソフト。

2022 年にフォークされたのでそっちを利用。

- フォーク元 SourceForge: https://sourceforge.net/projects/win32diskimager/
- フォーク先 GitHub: https://github.com/dnobori/DN-Win32DiskImagerRenewal
- Scoop: `scoop install win32-disk-imager` (extras bucket)、Renewal はなさそう

### WinSCP

FTP / SCP / SFTP / FTPS 対応クライアントソフト。

- Web サイト: https://winscp.net
- Scoop: `scoop install winscp` (extras bucket)

### Wireshark

ネットワークパケット解析ソフト。

- Web サイト: https://www.wireshark.org
- Scoop: `scoop install wireshark` (extras bucket)

### VcXsrv

Windows 用の X サーバーソフト。

- Web サイト: https://vcxsrv.sourceforge.io
- Scoop: `scoop install vcxsrv`
