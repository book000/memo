# OneDrive をエクスプローラーに表示させない

- 参考: [Windows10 エクスプローラーの OneDrive を隠す(表示させない)方法 - パソコンの問題を改善](https://pc-kaizen.com/windows10-hide-explorer-onedrive)

レジストリをいじる必要がある。

Personal は `HKCU\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}` 。大学などの Business 系の OneDrive はよくわからないが `HKCU\SOFTWARE\Classes\CLSID\` の下にあるっぽい。`(既定)` の値を見ながらかなあ。  
`System.IsPinnedToNameSpaceTree` を `0` にすることで表示を削除できる。

```powershell
reg add "HKCU\SOFTWARE\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v System.IsPinnedToNameSpaceTree /t REG_DWORD /d 0
```

エクスプローラーの再起動は不要。
