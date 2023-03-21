# Nuxt.js v3 のインストール + 初期設定

[Nuxt](https://nuxt.com/) の v3 インストール方法と初期設定について自分用にまとめたものです。  
Nuxt をインストールしたあと、Vuetify もいれます。さらに PWA 化もします。

## 環境

- `nuxt`: `3.0.0`
- `vuetify`: `3.0.5`
- `sass`: `1.57.0`
- `eslint`: `8.30.0`
- `eslint-plugin-nuxt`: `4.0.0`
- `@nuxtjs/eslint-config-typescript`: `12.0.0`

## スタータープロジェクトを入れる

`npx nuxi init <PROJECT-NAME>` でスタータープロジェクトを作成します。  
Yarn を使う場合でも、npx で作成するしかないようです。

`<PROJECT-NAME>` ディレクトリの下に、以下のファイルが生成されます。

- `.gitignore`
- `app.vue`
- `nuxt.config.ts`
- `package.json`
- `README.md`
- `tsconfig.json`

その後、プロジェクトのディレクトリに入り `yarn install` で依存パッケージをダウンロードします。  
`@types/node` のインストールも忘れずに。

```shell
yarn install
yarn install -D -E @types/node
```

ちなみに、当然 `package.json` には `name` とかの基本設定が書かれていないので、書き加えるのを忘れずに。

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

## eslint

```shell
yarn add -D eslint eslint-plugin-nuxt @nuxtjs/eslint-config-typescript vite-plugin-eslint
```

package.json にこのへんのスクリプトを追加。

```json title="package.json" hl_lines="8-9"
{
  "scripts": {
    "build": "nuxt build",
    "dev": "nuxt dev",
    "generate": "nuxt generate",
    "preview": "nuxt preview",
    "postinstall": "nuxt prepare",
    "lint": "eslint --ext .js,.ts,.vue --ignore-path .gitignore .",
    "lintfix": "eslint --ext .js,.ts,.vue --ignore-path .gitignore . --fix"
  }
}
```

さらに `nuxt.config.ts` に以下の設定を追加。

```typescript title="nuxt.config.ts" linenums="1" hl_lines="4-7"
const isDev = process.env.NODE_ENV === "development";

export default defineNuxtConfig({
  vite: {
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    plugins: [isDev ? require("vite-plugin-eslint")() : undefined],
  },
});
```

eslint の設定は [Nuxt v3 での eslint 設定](eslint.md) を参照。

prettier は使わない？

## Vuetify

- Vuetify の公式ドキュメント: https://next.vuetifyjs.com/
- 参考記事: https://zenn.dev/one_dock/articles/ab6d178741956d

```shell
yarn add -D vuetify@next @mdi/font
yarn add sass
```

`nuxt.config.ts` の `build` と `css` に以下の設定をします。

```typescript title="nuxt.config.ts" linenums="1" hl_lines="2-8"
export default defineNuxtConfig({
  build: {
    transpile: ["vuetify"],
  },

  css: [
    "vuetify/lib/styles/main.sass",
    "@mdi/font/css/materialdesignicons.min.css",
  ],
});
```

## PWA

公式の PWA モジュールは v3 に対応していないっぽいので、v2 と互換性のある非公式の PWA モジュールを利用します。

- npm: https://www.npmjs.com/package/@kevinmarrec/nuxt-pwa
- GitHub リポジトリ: https://github.com/kevinmarrec/nuxt-pwa-module

で、`nuxt.config.ts` の `modules` に定義します。

```typescript title="nuxt.config.ts" linenums="1" hl_lines="2"
export default defineNuxtConfig({
  modules: ["@kevinmarrec/nuxt-pwa"],
});
```

さらに、このモジュールはメタデータを引き継がないようなので、以下の通り PWA 用に設定する必要があります。

```typescript title="nuxt.config.ts" linenums="1"
const baseName = process.env.BASE_NAME || "example-app";
const baseDescription = process.env.BASE_DESCRIPTION || "Example app";
const baseUrl = process.env.BASE_URL || "https://example.com";
const siteColor = "#1d9bf0";

export default defineNuxtConfig({
  modules: ["@kevinmarrec/nuxt-pwa"],

  pwa: {
    manifest: {
      name: baseName,
      short_name: baseName,
      description: baseDescription,
      lang: "ja",
      theme_color: siteColor,
      background_color: siteColor,
      display: "standalone",
      start_url: "/",
    },
    meta: {
      name: baseName,
      description: baseDescription,
      theme_color: siteColor,
      lang: "ja",
      mobileAppIOS: true,
    },
  },
});
```

## Pinia

Nuxt.js v2 で利用されていた Vuex はバンドルされなくなり、開発者が状態管理ライブラリを選択できるようになった（らしい）。

2021 年 6 月ごろには Vuex 5 の情報があったのだが、[このディスカッション](https://github.com/vuejs/rfcs/discussions/270#discussioncomment-2467783) によれば Pinia が Vue における公式状態管理ライブラリという位置付けらしいので、これを使うことにします。

- 公式サイト: https://pinia.vuejs.org/
- GitHub: https://github.com/vuejs/pinia

なお、状態の永続化をするため [@pinia-plugin-persistedstate/nuxt](https://www.npmjs.com/package/@pinia-plugin-persistedstate/nuxt) を利用します。

まず、普通にパッケージをインストールします。

```shell
yarn add pinia @pinia/nuxt
```

次に、まあ例のごとく `nuxt.config.ts` の `modules` に追記します。

```typescript title="nuxt.config.ts" linenums="1" hl_lines="2-9"
export default defineNuxtConfig({
  modules: [
    ['@pinia/nuxt',
      {
        autoImports: ['defineStore', 'acceptHMRUpdate']
      }
    ],
    '@pinia-plugin-persistedstate/nuxt'
  ]
});
```

あとは Nuxt 3 における新しい state と同様に、`useState` を使って状態を定義します。

```typescript title="src/store/settings.ts"
export const useSettingsStore = defineStore('settings', {
  state: (): {
    hoge: string
    fuga: boolean
  } => ({
    hoge: "hogehoge",
    fuga: false,
  }),

  // getter をつくることもできる
  // getters: {},

  actions: {
    setHoge(hoge: string) {
      this.hoge = hoge
    },
  },

  persist: {
    storage: persistedState.localStorage
  }
})
```

`presist.storage` には `localStorage` のほかに `sessionStorage`, `cookies` が指定可能な様子。

そして、状態を使う場所で以下のようなコードを書きます。

```typescript
import { useSettingsStore } from '../store/settings'

const settingsStore = useSettingsStore()

const hoge = settingsStore.hoge
settingsStore.setHoge("hogepiyo")
```
