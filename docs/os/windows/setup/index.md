# 自分用PCセットアップ関連メモ

!!! warning "注意事項"
    本メモの内容に起因して生じた、あらゆる損害や障害について一切の責任を負わない。

## 環境

- Windows 11 26H2
  - Home (Build 26300.9711)
  - Pro（インストールメディアは Build 26300.9457）

2026 年 10 月に、仮想マシン上で Windows 11 26H2 のクリーンインストールと初期設定をやり直して、画面名やコマンドを確認した。25H2 では確認していない。再確認していない項目には「未確認」と書いている。

## クリーンインストールをする前に…

[初期化前に行う作業](before-reset.md) を必ず確認し実施。

## インストールメディアの作成

Windows のクリーンインストールにあたり、インストールメディア（USB メモリ）を作成しておくと良い。  
（回復オプションからリセットできるが、パーティション全部消して入れ直した方が綺麗になると思っている）

Microsoft の [Windows 11 をダウンロードする](https://www.microsoft.com/ja-jp/software-download/windows11) にアクセスし、`Windows 11 のインストールメディアを作成する` からツールをダウンロード。  
ダウンロードしたメディア作成ツールを実行して、インストールメディアを作成する。

## BIOS/UEFI の設定

参考: https://michisugara.jp/csm_secureboot

Windows 11 の要件は、UEFI ファームウェア（Secure Boot に対応していること）と TPM 2.0。Secure Boot の有効化そのものは要件ではなく推奨（Microsoft の要件ページの内容で、こちらでは未確認）。BIOS（UEFI）の設定がわかりにくいので、一応メモ。

- CSM を無効にする（Windows 7 以下が実行不可になる）
- Secure Boot を有効にする（起動時にデジタル署名をチェックする）
- 間違っても両方を有効にはしない
- ASUS のマザーボードなら起動設定（Boot）にある

!!! note "Secure Boot 証明書の更新"
    2011 年に発行された Secure Boot の証明書は 2026 年 6 月から順に失効し、Windows Production PCA 2011 は 2026 年 10 月 19 日に失効した。この情報は Issue #861 の調査によるもので、一次情報、証明書の更新手段、実機の状態は未確認。

## インストール

参考: https://www.ask-corp.jp/guide/pc-diy-part4.html

PCを起動する前に、Windows をインストールしたいストレージ以外のケーブルを外しておく。  
パーティションを削除するときにどのパーティションかわからなくなるので、絶対に外しておくのが吉。

BIOS/UEFI に入り、起動順を変えてインストールメディアとして作成した USB メモリで起動する。Windows 11 のインストーラーが起動するはず。  
インストーラーが起動したら、以下の手順でインストールする。

1. `言語設定を選択` と `キーボード設定を選択` を確認して進む。続く `セットアップ オプションの選択` で `Windows 11 のインストール` を選び、`ファイル、アプリ、設定など、すべてが削除されることに同意します(A)` にチェックを入れて `次へ`
2. `プロダクト キーを入力してください` の画面になる。クリーンインストールの場合ハードウェアの情報を使って認証するので、左下の `プロダクト キーがありません` をクリック
3. `イメージの選択` の画面で、インストールするエディションを選ぶ。選択肢は Home、Education、Pro、Pro Education、Pro for Workstations の 5 つ
4. ライセンス条項で `同意する(A)` をクリック
5. `Windows 11 をインストールする場所の選択` に進む。以前あった `カスタム` を選ぶ画面は出ない
6. 再インストールの場合は、すべてのパーティションを削除し、1 つの `割り当てられていない領域` にする。パーティションを 1 つずつ選んで `パーティションの削除(D)` をクリックする。確認の画面は出ない。システム、MSR、Windows 本体、回復の 4 つがあり、回復パーティションも削除する（削除しないと残る）。新しい空のディスクでは、この手順は不要
7. `割り当てられていない領域` を選択して `次へ` をクリックする。パーティションを事前に作る必要はなく、インストーラーが自動で作る
8. `インストール準備完了` で `インストール(I)` をクリックする。画面に `Windows 11 Home をインストール`（Pro を選んだ場合は `Windows 11 Pro をインストール`）と `何も引き継がない` が表示されていることを確認する
9. `Windows 11 をインストールしています` の画面で進捗が表示され、数回再起動する。終わると、国や地域を選ぶ画面になる

## インストール時の初期設定

参考: https://a-zs.net/win11_msaccountkaihi/

Windows 11 のインストール処理が終わると、国や地域を選ぶ画面が表示される。

Microsoft アカウントを利用するならこのまま進んでも良い。ネットワークに接続していると、更新プログラムの確認とデバイス名の入力（`スキップ` できる）を経て、`Microsoft エクスペリエンスのロックを解除する` で Microsoft アカウントのサインインを求められる。Home では、ここにローカルアカウントへの導線はない（Pro は後述の「ドメインに参加する」経路がある）。

ローカルアカウントを利用するなら、次のどちらかの方法を使う。詳細と確認結果は [Windows 11 の初期設定（OOBE）でローカルアカウントを作成する](../win11-oobe-local-account.md) にまとめている。

- ++shift+f10++ でコマンド プロンプトを開き、`start ms-cxh:localonly` を実行する（Home で確認。ネットワークの有無を問わない）
- Pro の場合は、`このデバイスをどのように設定しますか?` で `職場または学校用に設定する` を選び、`サインイン オプション` から `代わりにドメインに参加する` を選ぶ

その後、以下の設定が表示されるので適宜進める。

- `このデバイスを使うのはだれですか?`: ここで入力した文字列がユーザー名となり、ユーザーフォルダ名（`C:\Users\<ユーザー名>`）にもなる。アルファベットで入力するのが無難
- `確実に覚えやすいパスワードを作成します`: ログイン時のパスワードを設定（次の画面で再入力）
- `ここでセキュリティの質問を追加します`: 3 問とも必須。適宜設定
- `デバイスのプライバシー設定の選択`: お好きにだが、すべてオフ（拒否）で良い。5 つのトグル（位置情報、デバイスの検索、診断データ、手書き入力とタイプ入力、パーソナライズされたオファー）があり、初期値はすべてオン。1 つ切り替えるたびに配置がずれる

デスクトップが表示されれば、Windows 11 のインストールと初期設定は完了。  
この後は利便性を上げるための設定をする。

## Windows Update の実施

デバイスドライバーなどの関係で、この段階で Windows Update をしておくのが良い。  
Windows Update で入らないドライバーは別途インストールを行う。

ネットワークに接続した状態で初期設定を進めた場合、OOBE のなかで更新が入る（26300.9457 のメディアが 26300.9711 になった）。ネットワークなしで進めた場合は、デスクトップで更新する。

## Windows を使う上での推奨設定

Windows を使う上での個人的なおすすめ設定を行う。

### デバイス名の変更

`システムのプロパティ`（`SystemPropertiesComputerName.exe`）の `コンピューター名/ドメイン名の変更` で変更する。  
変更後は再起動が必要で、デバイス名は Firefox が利用するので最初にやったほうがよい。

ネットワークに接続した状態で初期設定を進めると、OOBE に `デバイス名を入力` の画面が出る。ここで名前をつけることもできる（つけると再起動する）。`詳細オプションを表示する` を開くと、後から変更できない `ユーザー フォルダー名` を指定する欄もある（指定しない場合は、ユーザー名がフォルダ名になる）。

コマンドラインからも変更可能。**管理者権限で** PowerShell を開いて以下を実行。

```powershell
Rename-Computer -NewName "<COMPUTER-NAME>"
Add-Computer -WorkgroupName "<WORKGROUP-NAME>"
Restart-Computer
```

`wmic` は Windows 11 から削除されていて、26300.9711 では実行できない（[KB5067470](https://support.microsoft.com/help/5067470)）。上の PowerShell のコマンドを実行すると、`変更は、コンピューター <旧名> の再起動後に有効になります。` という警告が 2 回表示される。再起動後に、デバイス名とワークグループが変わる。

### ブラウザのインストール

Chrome や Firefox など、お好きなブラウザをインストールする。以下はインストールページへのリンク。

- [Chrome](https://www.google.com/intl/ja_jp/chrome/)
- [Firefox](https://www.firefox.com/ja/download/windows/)

### エクスプローラの設定

まず、隠しフォルダ・ファイルと拡張子を表示する設定をする。

エクスプローラを開き、上部ナビゲーションバーの `表示` から `表示` を開き、以下の設定をする。

- [x] `ファイル名拡張子`
- [x] `隠しファイル`

![](assets/image.png)

さらに、`・・・` から `オプション` を開き、以下の設定も行う。

- `全般` タブ
  - `エクスプローラーで開く`: `PC`
  - `プライバシー`
    - [ ] `最近使用したファイルを表示する`
    - [ ] `使用頻度の高いフォルダーを表示する`

以前あった `Office.com のファイルを表示する` はなくなった。代わりに `推奨セクションを表示する` と、`アカウント ベースの分析情報、最近使用したファイル、お気に入りファイル、おすすめのファイルを含める` が増えている（この 2 つは設定を変えていないので、効果は未確認）。`使用頻度の高いフォルダーを表示する` をオフにすると、ホームの `クイック アクセス` が消える。

コマンドラインで設定する場合は、PowerShell で以下を実行する。エクスプローラを開き直すと反映される。

```powershell
$adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $adv HideFileExt 0                  # ファイル名拡張子を表示（隠す場合は 1）
Set-ItemProperty $adv Hidden 1                       # 隠しファイルを表示（隠す場合は 2）
Set-ItemProperty $adv LaunchTo 1                     # エクスプローラーで開く: PC（ホームは 0）
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer ShowFrequent 0  # 使用頻度の高いフォルダーを表示しない
```

`最近使用したファイルを表示する` は、スタートの設定と連動している（後述）。

### タスクバーの設定

設定アプリを開き、`個人用設定` から `タスクバー` を開き、以下の設定をする。

[`個人用設定 -> タスクバー` を開く](ms-settings:taskbar){ .md-button }

- `タスクバー項目`
  - `検索`: `非表示`
  - `タスク ビュー`: `オフ`
  - `ウィジェット`: `オフ`
- `タスク バーの動作`
  - `タスク バー アイコンの配置`: `左揃え`

`チャット` の項目はなくなった。`タスク バーの配置` は `タスク バー アイコンの配置` に名前が変わり、既定は `中央揃え`。このほかに、`タスク バーの位置`（下、上、左、右）、`タスク バーのサイズ調整`、`再開`、`タスク バーからウィンドウを共有する`、`縮小したアプリ アイコンを表示` が増えている。

コマンドラインで設定する場合は、PowerShell で以下を実行する（エクスプローラを再起動しなくても反映される）。

```powershell
$adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Search SearchboxTaskbarMode 0  # 検索: 非表示（検索ボックスは 2）
Set-ItemProperty $adv ShowTaskViewButton 0           # タスク ビュー: オフ
Set-ItemProperty $adv TaskbarAl 0                    # アイコンの配置: 左揃え（中央揃えは 1）
```

`ウィジェット` は、レジストリ値 `TaskbarDa` が管理者の PowerShell でも「アクセスが拒否されました」になり、書き込めない。コマンドラインで消す場合は、管理者の PowerShell で次のポリシーを設定する。PC 全体に効き、設定アプリのトグルがグレーアウトのオフになる。

```powershell
reg add HKLM\SOFTWARE\Policies\Microsoft\Dsh /v AllowNewsAndInterests /t REG_DWORD /d 0 /f
Stop-Process -Name explorer -Force                   # エクスプローラーを再起動
```

### スタートメニューのカスタマイズ

設定アプリにて、`個人用設定` → `スタート` に進み、以下を変更。

[`個人用設定 -> スタート` を開く](ms-settings:personalization-start){ .md-button }

- `新着順` の下
  - `最近追加したアプリを表示する`: オフ
  - `最近使ったファイルとおすすめのファイルを表示する`: オフ
  - `ヒントとアプリの推奨事項を表示する`: オフ
- `すべて` の下の `最もよく使用するアプリを表示する (グリッド ビューとリスト ビューのみ)`: オフ（既定でオフ）
- `アカウントに関連する通知を表示`: オフ
- `ジャンプ リストとエクスプローラーで最近使った項目を表示します`: オフ

22H2 の項目は、次のように変わっている。

| 22H2 の項目 | 26300.9711 |
|---|---|
| `レイアウト`: さらにピン留めを表示する | なくなり、`スタート メニューのサイズ`（既定は `自動`）に置き換わった |
| `最近追加したアプリを表示する` | `新着順` の下のチェック `最近追加したアプリを表示する` |
| `よく使うアプリを表示する` | `すべて` の下の `最もよく使用するアプリを表示する (グリッド ビューとリスト ビューのみ)` |
| `最近開いた項目をスタート、ジャンプ リスト、ファイル エクスプローラーに表示する` | `ジャンプ リストとエクスプローラーで最近使った項目を表示します` |
| `ヒント、ショートカット、新しいアプリなどのおすすめを表示する` | `新着順` の下の `ヒントとアプリの推奨事項を表示する` |
| `スタート画面にアカウント関連の通知を時々表示する` | `アカウントに関連する通知を表示` |
| （なし） | `最近使ったファイルとおすすめのファイルを表示する`、`スタート画面で名前とプロフィール画像を非表示にする`（既定はオフ） |

`ジャンプ リストとエクスプローラーで最近使った項目を表示します` をオフにすると、`最近使ったファイルとおすすめのファイルを表示する` のチェックと、エクスプローラの `フォルダー オプション` の `最近使用したファイルを表示する` も一緒にオフになる。3 か所が連動している。

コマンドラインで設定する場合は、PowerShell で以下を実行する（再起動しなくても反映される）。

```powershell
$adv = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $adv Start_IrisRecommendations 0    # ヒントとアプリの推奨事項を表示する: オフ
Set-ItemProperty $adv Start_AccountNotifications 0   # アカウントに関連する通知を表示: オフ
Set-ItemProperty $adv Start_TrackDocs 0              # 最近使った項目を表示: オフ
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Start ShowFrequentList 0  # 最もよく使用するアプリを表示する: オフ
```

`Start_TrackProgs` は `最もよく使用するアプリを表示する` のチェックボックスに効かなかった。`最近追加したアプリを表示する` のコマンドは未確認。

### テーマ・色の設定

設定アプリを開き、`個人用設定` から `テーマ` や `色` を選び、好みのテーマや色を選択する。

- [`個人用設定 -> テーマ` を開く](ms-settings:themes){ .md-button }
- [`個人用設定 -> 色` を開く](ms-settings:colors){ .md-button }

### ユーザーフォルダの移動

C ドライブにあるユーザーフォルダを別ドライブに移動する場合、以下の手順を踏む。

この手順は 26H2 では未確認。

GUI から変更する場合は、ユーザーフォルダを開き 1 つずつ `プロパティ` -> `場所` -> アドレスを変更 -> `OK` -> `移動` できる。

1. `C:\Users\<User>` を開く（`%HOMEDRIVE%%HOMEPATH%`）
2. 後述するフォルダのプロパティを開く
3. `場所` タブを開く
4. 保管場所のアドレスを変更する
5. `OK` をクリック
6. `フォルダーの作成` 画面が開くので、`はい` をクリック
7. `フォルダーの移動` 画面が開くので、`はい` をクリック

移動対象のフォルダは以下のとおり。

- `アドレス帳`
- `お気に入り`
- `ダウンロード`
- `デスクトップ`
- `ドキュメント`
- `ピクチャ`
- `ビデオ`
- `ミュージック`
- `リンク`
- `保存したゲーム`
- `検索`

### クリップボードの履歴機能を有効化

++win+v++ を押すことで、以下のようなクリップボード履歴機能が利用できる。

![](assets/image-3.png)

この機能は有効化しておかないと利用できないので、++win+v++ を押して機能の有効化をしておく。設定アプリの `システム` → `クリップボード` のトグルでも切り替えられる。

コマンドラインで設定する場合は、PowerShell で以下を実行する。サインアウトしてサインインし直すと設定アプリのトグルに反映される（`cbdhsvc` サービスの再起動だけでは反映されなかった）。

```powershell
New-Item -Force HKCU:\Software\Microsoft\Clipboard
Set-ItemProperty HKCU:\Software\Microsoft\Clipboard EnableClipboardHistory 1   # 無効にする場合は 0
```

### ウインドウを選ぶ時の全画面プレビューを無効化

デフォルトの設定では、タスクバーからウィンドウを選ぶだけでほかのウィンドウが透明化される。  
個人的にはこの挙動はウザいので、機能を無効にする。

1. `Windows のデザインとパフォーマンスの調整`（`SystemPropertiesPerformance.exe`）を開く
2. `視覚効果` タブにて、`プレビューを有効にする` のチェックボックスを **オフ** にする

コマンドラインで設定する場合は、PowerShell で以下を実行する。`視覚効果` タブが `カスタム` になり、`プレビューを有効にする` が外れた状態で開く。`VisualFXSetting` が `3`（カスタム）でないと、自動選択のままチェックが付いた表示になる。

```powershell
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects VisualFXSetting 3
Set-ItemProperty HKCU:\Software\Microsoft\Windows\DWM EnableAeroPeek 0   # オンに戻す場合は 1
```

### Windows の通知サウンドを切る

Windows はことあるごとに通知音を鳴らしてうるさいので、Windows の通知音を鳴らさないようにする。

1. `システム サウンドの変更` を開く  
   この設定は、[設定アプリの `システム -> サウンド`](ms-settings:sound) の `すべてのサウンド デバイス` と `音量ミキサー` の下にある `サウンドの詳細設定` からアクセスできる。`mmsys.cpl` を実行しても同じ「サウンド」画面が開く
2. `サウンド` タブを開く
3. `サウンド設定` を `サウンドなし` に変更
4. `OK` で保存

### 通信アクティビティの設定

Discord などで通話中にほかの音量が下がってしまう問題を解決するため、通信アクティビティで音量を変更しないようにする。

1. `システム サウンドの変更` を開く
2. `通信` タブを開く
3. `Windows が通信アクティビティを検出したとき:` で `何もしない` を選択
4. `OK` で保存する

コマンドラインで設定する場合は、PowerShell で以下を実行する。値は `0` がミュート、`1` が 80% 下げる（既定）、`2` が 50% 下げる、`3` が何もしない。

```powershell
New-Item -Force HKCU:\Software\Microsoft\Multimedia\Audio
Set-ItemProperty HKCU:\Software\Microsoft\Multimedia\Audio UserDuckingPreference 3
```

### モニターのリフレッシュレート設定

モニターが 144 Hz などの高いリフレッシュレートに対応している場合、設定を変更する必要がある。

設定アプリを開き、`システム` から `ディスプレイ` を開き、以下の設定をする。

[`システム -> ディスプレイ` を開く](ms-settings:display){ .md-button }

1. 対象のモニターを選択し、下にスクロールし `ディスプレイの詳細設定` をクリック
2. `リフレッシュ レートの選択` にて、選択可能な一番高いリフレッシュレートを選ぶ

この手順は未確認（検証した仮想マシンには、リフレッシュレートを選べる実ディスプレイがない）。

### 起動時の「PCのセットアップを完了しましょう」を止める

- 参考: https://atmarkit.itmedia.co.jp/ait/articles/2403/18/news021.html

設定アプリを開き、`システム` から `通知` を開き、以下の設定をする。

[`システム -> 通知` を開く](ms-settings:notifications){ .md-button }

1. 下にスクロールし、 `追加の設定` をクリック
2. すべてのチェックボックスのチェックを外す

チェックボックスは 2 つ（既定はどちらもオン）。

- `Windows を最大限に活用し、このデバイスの設定を完了する方法を提案する`
- `Windows を使用する際のヒントや提案を入手する`

コマンドラインで設定する場合は、PowerShell で以下を実行する。2 つのチェックがどちらも外れた状態になる。

```powershell
New-Item -Force HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement
Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement ScoobeSystemSettingEnabled 0
$cdm = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager'
Set-ItemProperty $cdm SubscribedContent-310093Enabled 0
Set-ItemProperty $cdm SubscribedContent-338389Enabled 0
```

### NVIDIA app をインストールし、ディスプレイドライバーを入れる

NVIDIA のグラボを刺している場合、サブディスプレイはディスプレイドライバーを入れないと利用できない（らしい）。  
GeForce Experience は NVIDIA app に置き換えられた。[NVIDIA app のページ](https://www.nvidia.com/ja-jp/software/nvidia-app/) から、インストーラーをダウンロード、インストールする（旧 GeForce Experience の URL は、このページに転送される）。

その後、ドライバータブから GeForce Game Ready ドライバーをインストールする。この手順は、NVIDIA のグラフィックス カードがない環境では確認できていないので未確認。

## 高度な初期設定

### 標準アプリケーションを削除

Windows は標準で不要なアプリケーションを大量にインストールするので、これを PowerShell からまとめてアンインストールする。

参考: https://ygkb.jp/22500#delete-all

とりあえず、私の環境では以下はいらないので実行

```powershell
Get-AppxPackage Clipchamp.Clipchamp | Remove-AppxPackage                       # Clipchamp
Get-AppxPackage Microsoft.549981C3F5F10 | Remove-AppxPackage                   # Cortana（26300.9711 の Home では存在しない）
Get-AppxPackage Disney.37853FC22B2CE | Remove-AppxPackage                      # Disney+（26H2 の Home では存在しない）
Get-AppxPackage MSTeams | Remove-AppxPackage                                   # Microsoft Teams（新しい Teams）
Get-AppxPackage MicrosoftTeams | Remove-AppxPackage                            # Microsoft Teams（旧 Chat 用。26300.9711 の Home では存在しない）
Get-AppxPackage Microsoft.Todos | Remove-AppxPackage                           # Microsoft To Do
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage              # Office on the Webへようこそ（26H2 の Home では存在しない）
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage    # Solitaire
Get-AppxPackage SpotifyAB.SpotifyMusic | Remove-AppxPackage                    # Spotify（26H2 の Home では存在しない）
Get-AppxPackage Microsoft.GamingApp | Remove-AppxPackage                       # Xbox ストア画面
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage               # Xbox Game Bar
Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage                       # Xbox その他
Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage                 # Xbox その他（26300.9711 の Home では存在しない）
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage            # Xbox その他
Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage         # Xbox その他
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage                       # 映画 & テレビ（26300.9711 の Home では存在しない）
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage                   # カメラ
Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage                       # スマホ同期
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage                     # 天気
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage                      # ヒント（26300.9711 の Home では存在しない）
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage              # フィードバック Hub
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage            # ボイス レコーダー
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage                     # マップ（26300.9711 の Home では存在しない）
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage       # メール、カレンダー（26300.9711 の Home では存在しない）
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage                       # メディアプレーヤー
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage                        # ニュース
Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage                         # ヘルプ
Get-AppxPackage Microsoft.People | Remove-AppxPackage                          # People（26300.9711 の Home では存在しない）
Get-AppxPackage MicrosoftCorporationII.QuickAssist | Remove-AppxPackage        # クイック アシスト
```

`Microsoft.BingNew` という名前のパッケージは存在しない（ニュースは `Microsoft.BingNews`）。

「26300.9711 の Home では存在しない」と書いたものは、最初から入っていなかった。実行しても何も起きない（エラーにもならない）。Pro は確認していない。

`Remove-AppxPackage` は、実行したユーザーからアプリを削除するだけで、新しく作るユーザーには再び入る。すべてのユーザーから消してプロビジョニングも外す場合は、**管理者権限で** `-AllUsers` をつける。

```powershell
Get-AppxPackage -AllUsers Microsoft.Todos | Remove-AppxPackage -AllUsers
```

`-AllUsers` で、26300.9711 の Home に入っていた `NonRemovable` が `False` の 52 エントリ（Microsoft Store、Edge、Terminal、メモ帳、ペイントなども含む）をすべて削除できた。実行後、`Get-AppxProvisionedPackage -Online` の結果は 0 件になった。削除できるからといって広げすぎると、Store や Terminal を再インストールする手間が出る。

26300.9711 の Home には、上のリストにない次のアプリも入っていて、削除できる。

- `Microsoft.Copilot`（Copilot）
- `Microsoft.OutlookForWindows`（新しい Outlook）
- `Microsoft.BingSearch`
- `Microsoft.PowerAutomateDesktop`（Power Automate）
- `Microsoft.Windows.DevHome`（Dev Home）
- `Microsoft.WindowsStore`、`Microsoft.WindowsTerminal`、`Microsoft.WindowsNotepad`、`Microsoft.Paint`、`Microsoft.Windows.Photos` など（削除すると困るので、通常は残す）

`Microsoft.SecHealthUI`、`Microsoft.DesktopAppInstaller`（winget）、`Microsoft.Windows.ShellExperienceHost`、`Microsoft.AAD.BrokerPlugin` は `NonRemovable` で、`Remove-AppxPackage -AllUsers` が `0x80070032 この要求はサポートされていません` で失敗する。ほかの `NonRemovable` のパッケージを個別には試していない。

なお、調査は以下のコマンドで実施できる。

```powershell
Get-AppxPackage | Where-Object IsFramework -eq $false | Where-Object NonRemovable -eq $false | Select-Object Name | Sort-Object Name
```

### 不要サービスの停止

PCを利用する上で不要なサービスがあるなら、適宜停止する。コマンドは管理者権限で実施すること。

参考: https://ygkb.jp/22889

26300.9711 の Home で、各サービスの状態を確認した。

- 起動の種類が `自動` なのは `DiagTrack`（実行中）、`TrkWks`（実行中）、`MapsBroker`（停止中）の 3 つだけ。無効化で実際に変わるのは、この 3 つ
- `AxInstSV`、`MSDTC`、`MSiSCSI`、`WPDBusEnum`、`SCardSvr`、`ScDeviceEnum`、`SCPolicySvc`、`SNMPTrap`、`TapiSrv`、`upnphost`、`WMPNetworkSvc`、`RetailDemo`、`CertPropSvc`、`SharedAccess` は、最初から `手動` で停止している。無効化しなくても動かない
- `Fax`、`PNRPsvc`、`p2psvc`、`p2pimsvc`、`PNRPAutoReg` は存在しない

```powershell
# Connected User Experiences and Telemetry
sc.exe stop DiagTrack
sc.exe config DiagTrack start=disabled

# Distributed Link Tracking Client
sc.exe stop TrkWks
sc.exe config TrkWks start=disabled

# Downloaded Maps Manager
sc.exe stop MapsBroker
sc.exe config MapsBroker start=disabled
```

以下は、最初から `手動` で停止しているサービス。無効化すると、手動でも起動できなくなる。

```powershell
# ActiveX Installer (AxInstSV)
sc.exe stop AxInstSV
sc.exe config AxInstSV start=disabled

# Distributed Transaction Coordinator
sc.exe stop MSDTC
sc.exe config MSDTC start=disabled

# Microsoft iSCSI Initiator Service
sc.exe stop MSiSCSI
sc.exe config MSiSCSI start=disabled

# Portable Device Enumerator Service
sc.exe stop WPDBusEnum
sc.exe config WPDBusEnum start=disabled

# Smart Card
sc.exe stop SCardSvr
sc.exe config SCardSvr start=disabled

# Smart Card Device Enumeration Service
sc.exe stop ScDeviceEnum
sc.exe config ScDeviceEnum start=disabled

# Smart Card Removal Policy
sc.exe stop SCPolicySvc
sc.exe config SCPolicySvc start=disabled

# SNMP Trap
sc.exe stop SNMPTrap
sc.exe config SNMPTrap start=disabled

# Telephony
sc.exe stop TapiSrv
sc.exe config TapiSrv start=disabled

# UPnP Device Host
sc.exe stop upnphost
sc.exe config upnphost start=disabled

# Windows Media Player Network Sharing Service
sc.exe stop WMPNetworkSvc
sc.exe config WMPNetworkSvc start=disabled

# 市販デモ サービス
sc.exe stop RetailDemo
sc.exe config RetailDemo start=disabled
```

!!! note "無効化しないサービス"
    `CertPropSvc`（Certificate Propagation）は、無効化しないよう Microsoft が案内しているという情報が Issue #861 にある（出典は未確認）。`SharedAccess`（Internet Connection Sharing）は、Hyper-V や WSL2 のネットワークに影響する可能性がある（未確認）。どちらもリストに載せていない。

### ゲーム起動時に Xbox オーバーレイの通知を消す

<!-- textlint-disable preset-ja-technical-writing/no-mix-dearu-desumasu -->
ストアアプリを消したりサービスを止めたことで Minecraft などのゲーム起動時に「この ms-gamingoverlay リンクを開くには新しいアプリが必要です」というポップアップが出る。  
<!-- textlint-enable preset-ja-technical-writing/no-mix-dearu-desumasu -->
これを表示しないようにする。

参考: https://narolll.hateblo.jp/entry/20220503/1651540497

1. レジストリエディタ（`regedit`）を開く
2. `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR` に移動
3. 右側のペインで右クリックし、`新規` → `DWORD (32 ビット) 値` から、`AppCaptureEnabled` を作成。キーではなく値を作る
4. `AppCaptureEnabled` をダブルクリックし、値のデータに `0` を入力し `OK` をクリック。

コマンドラインでは、PowerShell で以下を実行する。

```powershell
New-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR -Name AppCaptureEnabled -PropertyType DWord -Value 0 -Force
```

26300.9711 の Home では、`GameDVR` キーには `KGLToGCSUpdatedRevision` と `KGLRevision` の 2 つの値しかなく、`AppCaptureEnabled` は最初から存在しない（`{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}` のサブキーを作る必要はない）。`HKCU\System\GameConfigStore` の `GameDVR_Enabled` は最初から `0`。

ポップアップは、Xbox 系のアプリを削除したあとに `start ms-gamingoverlay://kglcheck` を実行すると再現できた。表示は「アプリを取得してこの 'ms-gamingoverlay' リンクを開く」と「お使いの PC には、このリンクを開くことができるアプリがありません。」。`AppCaptureEnabled` を `0` にすると実際のゲーム起動時のポップアップが消えるかは、ゲームを起動しての確認ができていないので未確認。

### ファイルなどの右クリックメニューを戻す

Windows 11 になって右クリックメニュー（コンテキストメニュー）が簡素化された。これで十分なら良いのだが、そうでないことの方が多いので Windows 10 の時のメニューに戻す。

参考: https://pc-karuma.net/right-click-context-menu-back-on-windows-11/

1. レジストリエディタ（`regedit`）を開く
2. `HKEY_CURRENT_USER\Software\Classes\CLSID` に移動
3. `CLSID` を右クリック
4. `新規` → `キー` から、`{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}` のキーを作成。
5. 作成したキー `{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}` を右クリックし、`新規` → `キー` から、`InprocServer32` を作成。
6. `(既定)` をクリックし、空白の状態で `OK` をクリック
7. タスクマネージャーなどからエクスプローラを再起動

26300.9711 の Home でも効く。デスクトップの右クリックメニューが、`表示(V)`、`並べ替え(O)`、`最新の情報に更新(E)`、`貼り付け(P)`、`ターミナルで開く(T)`、`新規作成(W)` などの従来の形式に戻る。

コマンドラインでは、PowerShell で以下を実行する。

```powershell
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
Stop-Process -Name explorer -Force
```

### スタートメニューの Web 検索を無効化する

Windows キーを押してキーワード入力したとき、PC 内のアプリケーションなどを検索できるが、そのときに Web 検索されるのをやめたい。

参考: https://www.tomshardware.com/how-to/disable-windows-web-search

1. レジストリエディタ（`regedit`）を開く
2. `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows` に移動
3. `Windows` を右クリック
4. `新規` → `キー` から、`Explorer` のキーを作成。
5. 作成したキー `Explorer` を右クリックし、`新規` → `DWORD (32 ビット) 値` から、`DisableSearchBoxSuggestions` を作成。
6. `DisableSearchBoxSuggestions` をダブルクリックし、値のデータに `1` を入力し `OK` をクリック。
7. タスクマネージャーなどからエクスプローラを再起動

26300.9711 の Home でも効く。設定後にスタートで `tokyo weather` を検索すると「結果が見つかりません」になり、`ウェブ` タブと Web 検索の結果が消える。

コマンドラインでは、**管理者権限の** PowerShell で以下を実行する。昇格していない PowerShell では「アクセスが拒否されました」になる（`regedit` は UAC で昇格されるので、上の手順は問題ない）。

```powershell
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f
Stop-Process -Name explorer -Force
```

### winget (アプリ インストーラー) の更新

アプリ インストーラー（winget）は、Microsoft Store 経由で更新される。26300.9711 の Home では、最初に入っている winget は v1.11.510 だった。

Microsoft Store を開き、左のメニューの `更新とダウンロード` で `更新プログラムの確認` をクリックする（`ms-windows-store://downloadsandupdates` でも開ける）。インストール済みのアプリがまとめて更新され、数分後に winget が v1.29.380 になった。

PowerShell から `winget upgrade Microsoft.AppInstaller` を実行しても更新対象として見つかるが、Store での更新前に実行したところ、`This package has a dependency missing from your system.` で失敗した（終了コード `0x80073cf3`）。先に Store で更新するほうが確実。

## ソフトウェアのインストールや設定

### Avast

アンチウイルスソフトとして Avast を利用している。

この節の手順と画面の項目名は、26H2 では未確認（Avast を入れていない環境で検証したため）。

[Avast のトップページ](https://www.avast.co.jp) にアクセスし、`今すぐ無料ダウンロード` からインストーラーをダウンロードし実行する。  
セットアップ画面が開いたら、`カスタマイズ` をクリックし、以下を実施する。

インストールするコンポーネントは以下のように選択する。

- [x] `ファイル シールド`
- [x] `挙動監視シールド`
  - [x] `ランサムウェア シールド`
- [x] `ウェブ シールド`
- [x] `メール シールド`
- [x] `ファイアウォール`
- [ ] `ソフトウェア アップデータ`
- [x] `ブラウザ クリーンアップ`
- [ ] `レスキュー ディスク`
- [ ] `ネットワーク インスペクター`
- [ ] `パスワード(旧)`
- [x] `クリーンアップ`
- [ ] `サイレントモード`

![](assets/image-5.png)

インストール後、Avast 設定内で以下の設定をする。  
設定へは右上 `メニュー` → `設定` でアクセスできる。

#### 使用状況の共有を無効化

1. `一般`
2. `個人のプライバシー`
3. 以下のチェックを外す
   - `アプリ使用状況データをアバストと共有して、このアプリとその他のアバスト製品の改善にご協力ください。`
   - `アプリの使用状況データを アバスト と共有して、サードパーティーの製品を提供できるようにします。`
   - `このアプリのコミュニケーションと製品の推奨事項をパーソナライズします。`

![](assets/image-6.png)

#### SSL/TLS 証明書の上書き無効化

この設定がオンになっていることで、コンテンツの中身が精査されてウイルス検知できるようにはなるのだが、`wget` や `curl` での HTTPS 通信が行えなくなるので無効化する。

1. `プロテクション`
2. `メイン シールド`
3. （下にスクロールして）`シールドを設定` で `ウェブ シールド`
4. 以下のチェックを外す
   - `HTTPS スキャンを有効にする`
   - `QUIC/HTTP3 スキャンを有効にする`
   - `WebSocket プロトコル スキャンを有効にする`

![](assets/image-7.png)

#### メール署名を無効化

1. `プロテクション`
2. `メイン シールド`
3. （下にスクロールして）`シールドを設定` で `メール シールド`
4. `送信するメールの末尾に署名を追加` のチェックを外す

![](assets/image-8.png)

### Firefox

メインブラウザとして利用する。拡張機能などの同期は Firefox アカウントで行う。

- [公式サイト](https://www.firefox.com/ja/)
- [ダウンロードリンク](https://www.firefox.com/ja/download/windows/)
- `winget install Mozilla.Firefox`

### Chrome

サブブラウザとして利用する。  
拡張機能などの同期は Google アカウントで行う。

- [公式サイト](https://www.google.com/intl/ja_jp/chrome/)
- [ダウンロードリンク](https://www.google.com/intl/ja_jp/chrome/thank-you.html?statcb=0)
- `winget install Google.Chrome`

### Opera

YouTube などで動画を見たり音楽を聞いたりするために使う。  
拡張機能などの同期は行わない。（Chrome 拡張機能を入れているので壊れそう…）

- [公式サイト](https://www.opera.com/ja)
- [ダウンロードリンク](https://www.opera.com/ja/computer/thanks?ni=stable&os=windows)
- `winget install Opera.Opera`

インストールする拡張機能は以下の通り。

- Install Chrome Extensions: 削除された様子（Opera アドオンのページは 404）。開発者モードからインストールする。
- [Enhancer for YouTube™](https://chromewebstore.google.com/detail/enhancer-for-youtube/ponfpcnoihfmfllpaingbgckeeldkhle)
  - 設定ファイル: [enhancer-for-youtube-settings.json](./enhancer-for-youtube-settings.json)
- [YouTube™ デュアル字幕](https://chromewebstore.google.com/detail/youtube-dual-subtitles/hkbdddpiemdeibjoknnofflfgbgnebcm)
- [YouTube NonStop](https://chromewebstore.google.com/detail/youtube-nonstop/nlkaejimjacpillmajjnopmpbkbnocid): 2023 年以降更新されていない（Issue #861 の調査による）
- [DetailedTime](https://chromewebstore.google.com/detail/detailedtime/ppgpbdnncfccljjkgfednccihjbakahd)
- [PreMiD](https://chromewebstore.google.com/detail/premid/agjnjboanicjcpenljmaaigopkgdnihi)
- [Web Scrobbler](https://chromewebstore.google.com/detail/web-scrobbler/hhinaapppaileiechjoiifaancjggfjm)
  - `General` と `YouTube` オプションはすべてチェックを外すこと

### Scoop

古い PC からストレージごと移している場合、以下の手順を **Scoop のインストール前** に行う。

!!! warning "注意"
    インストール前に移行作業が必要なので、よく読んでから実施すること。

この節のコマンドは、26H2 の環境では実行していない（未確認）。

**インストールコマンド（`irm get.scoop.sh | iex`）を叩かず** に、以下のコードで SCOOP 環境変数を設定する。  
この際、`N:\Portable\Scoop\tomachi` など、shims ディレクトリがあるところを指すようにする。

```powershell
$env:SCOOP = '<SCOOP-DIR>'
[environment]::setEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
```

apps ディレクトリからインストールコマンドをリストアップするコマンドを **cmd.exe で叩く**。

```cmd
for /f "delims=;" %i in ('dir /b /ad %SCOOP%\apps') do ( echo scoop install %i>>restore.ps1 )
ren %SCOOP%\apps apps-old
```

これによって、`restore.ps1` が作成される。  
以下のコマンドで、**管理者権限ではない** PowerShell から Scoop をインストールする。

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

PowerShell で `restore.ps1` ファイルを実行する。

```powershell
powershell -ExecutionPolicy RemoteSigned -File restore.ps1
# or .\restore.ps1
```

### HackGen35 Console NF のインストール

プログラミングフォント HackGen に Nerd Fonts が入った HackGen35 Console NF をインストールする。

1. [yuru7/HackGen の Release ページ](https://github.com/yuru7/HackGen/releases) にアクセス
2. `HackGen_NF_vX.Y.Z.zip` をダウンロード、展開し、`HackGen35ConsoleNF-Regular.ttf` をインストール

### Terminal

Windows 11 から Terminal というものがインストールされるようになった。  
この画面から PowerShell もコマンドプロンプトも Windows Subsystem for Linux も触れるので意外と便利。

- `Ctrl+,` で設定を開き、`プロファイル` -> `既定値` を開く。ページ下部の `追加の設定` にある `外観` に入り、以下の設定をする
  <!-- textlint-disable ja-spacing/ja-no-space-between-full-width -->
  - フォント フェイス: `HackGen35 Console NF`
  <!-- textlint-enable ja-spacing/ja-no-space-between-full-width -->

項目名は `フォント フェイス`（Terminal 1.24.11911 で確認）。`フォント スタイル` という項目はない。

### Pwsh

Windows 10 にデフォルトで入っている PowerShell を使うと `新しいクロスプラットフォームの PowerShell をお試しください` って言われてうざいので、新しい Pwsh を入れておく。

26300.9711 の Home に入っている PowerShell（5.1.26100.9711）では、起動時に `Windows PowerShell` と著作権の 2 行だけが表示され、この案内は出なかった。Windows 11 でも案内が出るという情報が Issue #861 にあるが、再現しなかった。

- 参考: [Windows への PowerShell のインストール](https://learn.microsoft.com/ja-jp/powershell/scripting/install/installing-powershell-on-windows)

winget でインストールできる。以下のコマンドを実行（`winget search --id Microsoft.PowerShell --exact` でパッケージが存在することは確認した。7.6.9.0）。

```powershell
winget install Microsoft.PowerShell
```

### EarTrumpet

Windows 11 の音量ミキサーはどうにも使い勝手が悪い（特に複数アプリケーションから音を出している場合）ので、タスクバーでアプリケーションごとの音量調整ができる EarTrumpet を入れる。  
以下のように利用できる。

![](assets/image-9.png)

Microsoft Store の [EarTrumpet ページ](https://apps.microsoft.com/detail/9nblggh516xp) にアクセスし、ダウンロードするだけ。

### Thunderbird

メーラーとして Thunderbird を利用している。

!!! note "Note"
    Scoop でのインストールに切り替えた。この操作は不要。

[Thunderbird の Web サイト](https://www.thunderbird.net/ja/) からインストーラーをダウンロードできる。

`%APPDATA%\Thunderbird\Profiles` にプロファイルがあり、利用するプロファイルの定義は `%APPDATA%\Thunderbird\profiles.ini` にある。  
これらをリストアすればそのまま利用可能。

### Logicool G HUB

[Logicool G HUB の Web サイト](https://gaming.logicool.co.jp/ja-jp/software/ghub) からインストーラーをダウンロードできる。

`%LOCALAPPDATA%\LGHUB\settings.db` のファイルをリストアすることでそのまま利用可能。

### AnyDesk

[AnyDesk の Web サイト](https://anydesk.com/ja) からインストーラーをダウンロードできる。

`%ProgramData%\AnyDesk` をリストアすることで、エイリアスを継続して利用可能。

ポータブル版（インストールしない版）は `%APPDATA%\AnyDesk` に設定が保存され、ID は `service.conf` に保存される（Issue #861 の調査による。実機では未確認）。

### Visual Studio Code

[Visual Studio Code のページ](https://code.visualstudio.com/) にて、Visual Studio Code をインストールする。

### 仮想システム系

Hyper-V とか Windows Subsystem for Linux など、仮想システム系については [仮想システム系](virtual-systems.md) にて。

### fnm

別ページにて説明。[fnm のインストール](install-fnm.md) を参照。
