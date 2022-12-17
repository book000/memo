# Nuxt.js v3 を使う上での Tips

## 参考になるサイト

参考になりそうなサイトを書き出しておきます。

- 公式ドキュメント: https://nuxt.com/docs/
- Vue 2 から Vue 3 の公式移行ガイド: https://v3.ja.vuejs.org/guide/migration/introduction.html
- サービスを Nuxt 2 から Nuxt 3 に移行した記事: https://zenn.dev/skmt3p/articles/5c119886956cc9
- 変わったところをまとめられた記事: https://qiita.com/citrus_candy/items/6ba29c31e3e4afa7a5a1

## 新しい Vue ファイルの構成

ソースがどこだったか忘れたのですが、Vue 3 では以下の順番で各種タグブロックを置くのが一般的のようです。

- `<script>`
- `<template>`
- `<style>`

Nuxt 2 では、`<template>`, `<script>`, `<style>` の順番でした。

## script setup

Vue は script タグ以下の書き方がいろいろありすぎて困るのですが、[Vue の公式ドキュメント](https://v3.ja.vuejs.org/api/sfc-script-setup.html) で `<script setup>` の書き方がお勧めと言われているので、とりあえずこれを使うことにします。

`<script setup>` では以下の特徴があるようです。

- コンポーネントインスタンスが作成されるたびに実行（`oncreated` イベントが不要になる）
- 変数・関数宣言・インポートなどは `<template>` 内で直接利用可能
- 従来、`data()` 内で定義していた変数は `const count = ref(0)` のように定義するようです。
- 従来、`props()` 内で定義していたプロパティ的なアレは、`defineProps` 関数を用いて定義するようです。
- `emit` は `defineEmits` 関数で定義したうえで、`emit('hoge')` のように呼び出せるようです。
- 従来、`method()` 内で定義していたメソッドはコンポーネントの呼び出し元から `$ref` 経由で呼び出すことができました。Vue 3 からは外部から呼び出しても良いメソッドを明示的に `defineExpose` で公開しなければならないようです。

など、これらに沿って書くと以下のようなものが作れます。（長いので折りたたんでいます）

??? tip "カウントアップ・ダウンするコード"

    ```typescript
    // --- data
    const count = ref<number>(0)

    // --- props
    // script 内で props の値を使わない場合は変数に入れる必要はありません
    const props = defineProps({
      max: {
        type: Number,
        required: true
      },
      min: {
        type: Number,
        required: true
      },
    })
    /*
    // こんな書き方もできます:
    const props = defineProps<{
        max: number
        min: number
    }>()
    */

    // --- emit
    const emit = defineEmits<{
      (e: 'updated', newValue: Target[]): void
    }>()

    // --- watch
    watch(count, (val) => {
      emit('updated', val)
    })

    // --- methods
    const countUp = () => {
    if (count > max) throw new Error('これ以上はカウントアップできません')
      count++
    }

    const countDown = () => {
    if (count > max) throw new Error('これ以上はカウントダウンできません')
      count--
    }

    // expose
    defineExpose({ countUp, countDown })

    // mounted
    onMounted(() => {
      console.log('mounted')
    })
    ```

## Visual Studio Code 用のコードユニペット

```json
{
  "Nuxt3 setup-script": {
    "prefix": "<script>",
    "body": ["<script setup lang=\"ts\">", "$1", "</script>"],
    "description": "Nuxt3 script setup"
  },
  "Nuxt3 template": {
    "prefix": "<template>",
    "body": ["<template>", "$1", "</template>"],
    "description": "Nuxt3 template"
  }
}
```
