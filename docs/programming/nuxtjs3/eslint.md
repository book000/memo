# Nuxt v3 での eslint 設定

ref: https://github.com/nuxt/framework/discussions/2007

以下でよいっぽい。

```yaml title=".eslintrc.yml"
root: true
env:
  browser: true
  es2021: true
  node: true
parserOptions:
  ecmaVersion: latest
  sourceType: module
extends:
  - '@nuxtjs/eslint-config-typescript'
  - plugin:@typescript-eslint/recommended
  - plugin:vue/vue3-recommended
  - plugin:nuxt/recommended
```
