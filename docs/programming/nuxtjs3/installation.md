# Nuxt.js v3 のインストール + 初期設定

[Nuxt](https://nuxt.com/) の v3 インストール方法と初期設定について自分用にまとめたものです。  
Nuxt をインストールしたあと、Vuetify もいれます。さらに PWA 化もします。

公式の [Installation](https://nuxt.com/docs/getting-started/installation) を参考にして作業します。

## 環境

- `nuxt`: `3.13.2`
- `vuetify`: `3.7.3`
- `@nuxt/eslint`: `0.6.1`

## スタータープロジェクトを入れる

`npx nuxi@latest init <PROJECT-NAME>` でスタータープロジェクトを作成します。  
Yarn の場合は、`yarn dlx nuxi@latest init <PROJECT-NAME>`、pnpm の場合は `pnpm dlx nuxi@latest init <PROJECT-NAME>` を使います。

スタータープロジェクトのインストール処理のなかで、パッケージマネージャーが選択できるのでそれで依存パッケージもインストールされます。

## 基本的な設定

- meta タグ
- `components` ディレクトリとかを `src` ディレクトリに置きたいのでソースディレクトリを `src` にする
- 型チェックは `NODE_ENV` が `development` のときのみ行う
- `strict` は `true`

```typescript title="nuxt.config.ts" linenums="1"
const baseName = process.env.BASE_NAME || "example-app";
const baseDescription = process.env.BASE_DESCRIPTION || "Example app";
const baseUrl = process.env.BASE_URL || "https://example.com";
const isDev = process.env.NODE_ENV === "development";
const isSsr = true;

export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',
  devtools: { enabled: true },

  app: {
    head: {
      htmlAttrs: {
        lang: "ja",
      },
      meta: [
        { name: "viewport", content: "width=device-width, initial-scale=1" },
        { name: "apple-mobile-web-app-title", content: baseName },
        { name: "application-name", content: baseName },
        { name: "msapplication-TileColor", content: "#1d9bf0" },
        {
          name: "msapplication-config",
          content: baseUrl + "/favicons/browserconfig.xml",
        },
        { name: "theme-color", content: "#1d9bf0" },
        { key: "description", name: "description", content: baseDescription },
        { key: "og:site_name", property: "og:site_name", content: baseName },
        { key: "og:type", property: "og:type", content: "article" },
        { key: "og:url", property: "og:url", content: baseUrl },
        { key: "og:title", property: "og:title", content: baseName },
        {
          key: "og:description",
          property: "og:description",
          content: baseDescription,
        },
        {
          key: "twitter:card",
          name: "twitter:card",
          content: "summary",
        },
        {
          key: "msapplication-TileColor",
          name: "msapplication-TileColor",
          content: "#00aba9",
        },
        {
          key: "msapplication-config",
          name: "msapplication-config",
          content: baseUrl + "/favicons/browserconfig.xml",
        },
        {
          key: "theme-color",
          name: "theme-color",
          content: "#1da1f2",
        },
      ],
      link: [
        {
          rel: "apple-touch-icon",
          sizes: "180x180",
          href: baseUrl + "/favicons/apple-touch-icon.png",
        },
        {
          rel: "icon",
          type: "image/png",
          sizes: "32x32",
          href: baseUrl + "/favicons/favicon-32x32.png",
        },
        {
          rel: "icon",
          type: "image/png",
          sizes: "16x16",
          href: baseUrl + "/favicons/favicon-16x16.png",
        },
        {
          rel: "mask-icon",
          href: baseUrl + "/favicons/safari-pinned-tab.svg",
          color: "#5bbad5",
        },
        {
          rel: "shortcut icon",
          href: baseUrl + "/favicons/favicon.ico",
        },
      ],
      noscript: [{ children: "This website requires JavaScript." }],
    },
  },

  srcDir: "src/",

  ssr: isSsr,

  typescript: {
    typeCheck: isDev,
    strict: true,
  },
});
```

`src` ディレクトリに `app.vue` を移動すること。

## TypeScript 環境の有効化

以下のコマンドを実行し、TypeScript 環境を追加する。

```shell
pnpm add -D vue-tsc typescript
npx nuxi typecheck
```

## ESLint

以下で導入できるらしい。

```shell
npx nuxi module add eslint
```

prettier は使わないので、`.prettierignore` に以下を記述。

```text title=".prettierignore" linenums="1"
**
```

## Vuetify

https://nuxt.com/modules/vuetify-nuxt-module

以下を実行する。

```shell
npx nuxi@latest module add vuetify-nuxt-module
```

## PWA

https://nuxt.com/modules/vite-pwa-nuxt

以下を実行する。

```shell
npx nuxi@latest module add @vite-pwa/nuxt
```

## Pinia

https://nuxt.com/modules/pinia

以下を実行する。

```shell
npx nuxi@latest module add @pinia/nuxt
```
