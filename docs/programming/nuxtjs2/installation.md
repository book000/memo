# Nuxt.js v2 のインストール + 初期設定

[Nuxt.js(v2)で generate 納品する前にやっておきたい設定 - Qiita](https://qiita.com/amishiro/items/11bd642728f6b5838189) を参考に自分用にカスタムしています。  
基本的に、TypeScript・Yarn 環境で設定します。

## インストール

（create-nuxt-app@4.0.0 で確認）

```powershell
yarn create nuxt-app <PROJECT-NAME>
# npx create-nuxt-app <PROJECT-NAME>
```

`<PROJECT-NAME>` はプロジェクト名（英語）です。ディレクトリ名にもなります。

- `Project name`: 基本的にディレクトリ名と同じでよいと思うので、そのまま Enter
- `Programming language`: JavaScript か TypeScript を選びます。ここでは TypeScript を矢印で選んで Enter
- `Package manager`: Yarn か Npm を選びます。ここでは Yarn を矢印で選んで Enter
- `UI framework`: UI のフレームワークを選びます。ここでは Vuetify.js を選びます。
- `Nuxt.js modules` 追加導入するモジュールを選びます（複数選択可）。作りたいもの向けに矢印で選んでスペースで選択できます。
- `Linting tools`: リントツールを選びます（複数選択可）。基本的に全部アクティブでよいと思うので `a` で全アクティブ
- `Testing framework`: テストフレームワークを選びます。適宜。
- `Rendering mode`: レンダリングモードを選びます。作るものに応じて選択。
- `Deployment target`: デプロイ先を選びます。Node.js によるサーバーか静的データホストかを選びます。
- `Development tools`: 開発ツールを選びます。TypeScript 環境なので `jsconfig.json` は選びません。Dependabot を有効化すると GitHub でプルリクを使用した依存関係アップデートができますがフォーク先でも動いたりするのでやっかいです。

## nuxt.config.js を TypeScript ファイルに変更

`nuxt.config.js` を `nuxt.config.ts` にリネームし、内容を以下のように適宜変更します。

```diff
--- nuxt.config.js
+++ nuxt.config.ts
@@ -1,4 +1,6 @@
-export default {
+import { NuxtConfig } from '@nuxt/types'
+
+const config: NuxtConfig = {
   // Target: https://go.nuxtjs.dev/config-target
   target: 'static',

@@ -44,3 +46,5 @@
   build: {
   }
 }
+
+export default config
```

## ソースディレクトリの設定

プロジェクトルートにディレクトリがごちゃごちゃしていると微妙ですので、`src` にある程度まとめてしまおうと思います。

Pwsh でやってもよいですが、コマンド一発で複数ディレクトリを移動できないので素直に WSL 入ってコマンドたたいたほうがよいです。

```bash
mkdir src
mv assets components layouts pages plugins static store middleware src/
```

さらに、`nuxt.config.ts` に `srcDir: 'src/',` をいれておきましょう。

ついでに、`tsconfig.json` の `compilerOptions.paths` もいじっておきましょう。

```diff
{
  "compilerOptions": {
    "paths": {
-      "~/*": ["./*"]
+      "~/*": ["./src/*"]
    }
  }
}
```

## nuxt.config.ts の整頓（コメントの削除）

デフォルトの `nuxt.config.ts` は優しすぎてコメントが多すぎるので、適当に消してしまいます。

```bash
sed -i.bak -E 's/\/\/.+//g' nuxt.config.ts
```

改行消えないので、\n 含む置き換えでもよいかも。

## README.md の削除

ソースディレクトリの各ディレクトリに README.md があって邪魔なので削除してしまいます。

```bash
find . -type d -name node_modules -prune -o -type f -name 'README.md' -print
find . -type d -name node_modules -prune -o -type f -name 'README.md' -print | xargs rm -v
```
