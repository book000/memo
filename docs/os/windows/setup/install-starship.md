# Starship のインストール

Starship は、シェル用のミニマルで高速、かつ高度にカスタマイズ可能なプロンプトです。

## 前提条件

[Nerd Font](https://www.nerdfonts.com/) をインストールしてターミナルで有効にする必要があります。

推奨フォント：`HackGen35 Console NF`

## インストール方法

### 1. Scoop を使用（推奨）

管理者権限を必要とせず、ユーザー固有のインストールが可能です。

```powershell
scoop install starship
```

### 2. Winget を使用

Windows 11 に標準搭載されているパッケージマネージャーです。

```powershell
winget install --id Starship.Starship
```

### 3. Chocolatey を使用

管理者権限が必要です。

```powershell
choco install starship
```

## PowerShell の設定

PowerShell プロファイル（`~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`）に以下を追加してください。

```powershell
Invoke-Expression (&starship init powershell)
```

## パッケージマネージャーの選択指針

- **Scoop**：開発者向け、管理者権限が不要、ポータブルインストール
- **Winget**：Windows 11 ユーザー向け、もっともシンプルなセットアップ
- **Chocolatey**：最大のパッケージリポジトリ、管理者権限が必要
