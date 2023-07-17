# ユーザーフォルダの移動をコマンドラインから行う

以下のレジストリをいじることで [変更できる](https://www.inasoft.org/webhelp/rnsf7/HLP000209.html) らしい。

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
