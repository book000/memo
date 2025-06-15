# Starship のインストール

Starship は、シェル用のミニマルで高速、かつ高度にカスタマイズ可能なプロンプトです。

## 前提条件

### フォントの設定

[Nerd Font](https://www.nerdfonts.com/) をインストールしてターミナルで有効にする必要があります。

推奨フォント：`HackGen35 Console NF`

#### Windows 11 ターミナルでのフォント設定手順

1. Windows ターミナルを開く
2. ++ctrl+comma++ でターミナル設定を開く
3. 左側メニューから「プロファイル」→「PowerShell」を選択
4. 「外観」タブを開く
5. 「フォントフェース」を `HackGen35 Console NF` に変更
6. 「保存」をクリック

## インストール方法

Scoop を使用してインストールします。管理者権限を必要とせず、ユーザー固有のインストールが可能です。

```powershell
scoop install starship
```

## PowerShell の設定

PowerShell プロファイル（`~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`）に以下を追加してください。

```powershell
Invoke-Expression (&starship init powershell)
```

## 初期設定

### プロファイルファイルの作成

PowerShell プロファイルが存在しない場合は、以下のコマンドで作成できます。

```powershell
# プロファイルディレクトリを作成
New-Item -ItemType Directory -Path (Split-Path $PROFILE -Parent) -Force

# プロファイルファイルを作成
New-Item -ItemType File -Path $PROFILE -Force
```

### 設定の確認

PowerShell を再起動すると、Starship プロンプトが適用されます。正常に動作していることを確認してください。

### カスタマイズ

Starship の設定をカスタマイズする場合は、`~\.config\starship.toml` ファイルを作成して設定を記述します。詳細は [Starship 公式ドキュメント](https://starship.rs/ja-JP/config/) を参照してください。

