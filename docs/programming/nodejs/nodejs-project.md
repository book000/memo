# Node.js プロジェクトを立ち上げる手順

## 環境

- Windows 10 22H2 (Build 19045.2486)
- Node.js v18.13.0
- npm v8.19.3
- Yarn v1.22.19
- [typescript](https://www.npmjs.com/package/typescript) v4.9.5
- [@types/node](https://www.npmjs.com/package/@types/node) v18.13.0
- [ts-node](https://www.npmjs.com/package/ts-node) v10.9.1
- [ts-node-dev](https://www.npmjs.com/package/ts-node-dev) v2.0.0
- [prettier](https://www.npmjs.com/package/prettier) v2.8.4
- [eslint](https://www.npmjs.com/package/eslint) v8.34.0
- [eslint-config-standard](https://www.npmjs.com/package/eslint-config-standard) v8.6.0
- [eslint-config-prettier](https://www.npmjs.com/package/eslint-config-prettier) v17.0.0
- [eslint-plugin-import](https://www.npmjs.com/package/eslint-plugin-import) v2.27.5
- [eslint-plugin-n](https://www.npmjs.com/package/eslint-plugin-n) v15.6.1
- [eslint-plugin-promise](https://www.npmjs.com/package/eslint-plugin-promise) v6.1.1
- [eslint-plugin-unicorn](https://www.npmjs.com/package/eslint-plugin-unicorn) v45.0.2
- [yarn-run-all](https://www.npmjs.com/package/yarn-run-all) v3.1.1
- [@typescript-eslint/parser](https://www.npmjs.com/package/@typescript-eslint/parser) v5.51.0
- [@typescript-eslint/eslint-plugin](https://www.npmjs.com/package/@typescript-eslint/eslint-plugin) v5.51.0
- [@vercel/ncc](https://www.npmjs.com/package/@vercel/ncc) v0.36.1
- [winston](https://www.npmjs.com/package/winston) v3.8.2
- [winston-daily-rotate-file](https://www.npmjs.com/package/winston-daily-rotate-file) v4.7.1
- [logform](https://www.npmjs.com/package/logform) v2.5.1
- [cycle](https://www.npmjs.com/package/cycle) v1.0.3

## package.json の作成

- `name`: プロジェクトの名前。大文字を含んではならない。
- `version`: プロジェクトバージョン
- `description`: プロジェクトの説明
- `main`: エントリポイントのファイルパス
- `homepage`: Web サイトへの URL
- `repository`: GitHub への Git URL
- `bugs`: バグトラッカーへの URL
- `author`: 作者名。メールアドレスを入れる場合は `XXXXX <info@example.com>` のようにする。
- `license`: プロジェクトに適用するライセンス。`MIT` など
- `private`: true の場合、パッケージの公開を制限する

`yarn init` を使ってもよいし、そのまま `package.json` を作成して作ってもよい。

```shell
❯ yarn init
yarn init v1.22.19
question name (test):
question version (1.0.0):
question description:
question entry point (index.js):
question repository url:
question author:
question license (MIT):
question private:
success Saved package.json
Done in 5.07s.
```

https://garafu.blogspot.com/2016/11/packagejson-specification-ja.html

## Node.js バージョンの指定

[fnm](https://github.com/Schniz/fnm) などの Node.js バージョン管理ツールを利用している場合、`.node-version` などでプロジェクトで使用するバージョンを決定しておいたほうが安心。

```shell
node -v > .node-version
```

また、fnm などを利用していない人向けに `package.json` で対象の Node.js バージョンを明記しておく。  
以下の bash スクリプトで設定可能。

```bash
# bash (Windowsの場合はWSLなど)で実行すること

# .node-version ファイルを読み取り、改行と `v` を消す
# package.json を上書きはできないので、テンポラリファイルをつくる
jq --rawfile version .node-version '.engines.node |= ($version | gsub("[v\\r\\n]"; ""))' package.json > package.json.tmp
mv package.json.tmp package.json

# .node-version のバージョン固定になるので、18.x とか範囲指定にするといいかも。
```

## .gitignore を追加する

```shell
wget -O .gitignore https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore
```

!!! tip "Commit"

    ```shell
    git commit -am "feat: init"
    ```

## GitHub Actions による Node.js CI

[book000/templates](https://github.com/book000/templates) の `nodejs-ci.yml` を利用して、CI ワークフローを導入する。

```shell
mkdir -p .github/workflows ; wget -O .github/workflows/nodejs-ci.yml https://raw.githubusercontent.com/book000/templates/master/workflows/nodejs-ci.yml
```

必要に応じ、`with` オプションの `disabled-jobs` で実行しないスクリプト（`depcheck` など）を無効化すること。  
無効化する必要がないなら `with` オプションを削除すること。

!!! tip "Commit"

    ```shell
    git commit -am "ci: add node.js ci"
    ```

## TypeScript 環境の構築

まず、[`typescript`](https://github.com/microsoft/TypeScript) パッケージを依存関係に追加する。

```shell
yarn add -D -E typescript @types/node
```

そのあと、`tsconfig.json` を書く。

??? example "tsconfig.json サンプルと説明"

    ```json title="tsconfig.json"
    {
        "ts-node": { "files": true },
        "compilerOptions": {
            "target": "es2020",
            "module": "commonjs",
            "moduleResolution": "Node",
            "lib": ["ESNext", "ESNext.AsyncIterable"],
            "outDir": "./dist",
            "removeComments": true,
            "esModuleInterop": true,
            "allowJs": false,
            "incremental": true,
            "sourceMap": true,
            "declaration": true,
            "declarationMap": true,
            "strict": true,
            "noUnusedLocals": true,
            "noUnusedParameters": true,
            "noImplicitReturns": true,
            "noFallthroughCasesInSwitch": true,
            "noUncheckedIndexedAccess": true,
            "experimentalDecorators": true,
            "baseUrl": ".",
            "newLine": "LF",
            "paths": {
                "@/*": ["src/*"]
            }
        },
        "include": ["src/**/*"]
    }
    ```

    - `ts-node`: のちに追加する `ts-node` で `compilerOptions.paths` を機能させるためのおまじない？
    - `compilerOptions`
      - `target`: コンパイル後の成果物をどの ECMAScript バージョンを対象とする。とりあえず `es2020`
      - `module`: モジュールの読み込み方法
      - `moduleResolution`: モジュールの解決方法
      - `lib`: Proposal な機能の追加導入
      - `outDir`: コンパイル後の出力先
      - `removeComments`: コンパイル時にコメントを消す
      - `esModuleInterop`: `import * as xxx from "xxx"` を `import xxx from "xxx"` と書けるようにする
      - `allowJs`: `.js` と `.jsx` をコンパイル対象とするか
      - `incremental`: 差分コンパイルを有効
      - `sourceMap`: `.map` ファイルを生成するか
      - `declaration`: `export` した型定義の `.d.ts` を生成するか
      - `declarationMap`: `export` した型定義の `d.ts.map` を生成するか
      - `strict`: 以下を有効にする
        - `noImplicitAny`:  `any` になりうる値をエラーとする
        - `noImplicitThis`: `this` が `any` 型になりうる場合をエラーとする
        - `alwaysStrict`: `"use strict";` を入れる
        - `strictBindCallApply`: `bind`, `call`, `apply` の使用時に厳密な型チェックを行う
        - `strictNullChecks`: `null` になりうる値に対してメソッドなどの呼び出しをエラーとする
        - `strictFunctionTypes`: より厳密な関数型のチェックを行う？
        - `strictPropertyInitialization`: クラスのインスタンス変数の初期化を宣言時かコンストラクタで行っていない場合にエラーとする
      - `noUnusedLocals`: 宣言しているのに使っていない変数をエラーとする
      - `noUnusedParameters`: 定義しているのに使っていない関数パラメータをエラーとする
      - `noImplicitReturns`: いずれかの条件で `return` していない場合にエラーとする
      - `noFallthroughCasesInSwitch`: `switch` で `break` や `return` が抜けている場合にエラーとする
      - `noUncheckedIndexedAccess`: 配列の要素やプロパティアクセスで `undefined` になりうる場合にエラーとする
      - `baseUrl`: プロジェクトのルートパスを指定する
      - `newLine`: ファイルの改行コードを指定する
      - `paths`: 長いパスを短くするために `@/...` をマップする
    - `include`: コンパイル対象を指定する

https://typescriptbook.jp/reference/tsconfig/tsconfig.json-settings  
https://qiita.com/ryokkkke/items/390647a7c26933940470

最後に、コンパイルして実行のプロセスを 1 コマンドで行う `ts-node` を導入する。

```shell
yarn add -D -E ts-node ts-node-dev
```

`package.json` の `scripts` に以下を追加する。

```json title="package.json" hl_lines="2-5"
{
  "scripts": {
    "start": "ts-node -r tsconfig-paths/register ./src/main.ts",
    "dev": "ts-node-dev --poll -r tsconfig-paths/register ./src/main.ts"
  }
}
```

!!! tip "Commit"

    ```shell
    git commit -am "feat: add typescript"
    ```

## Lint / Formatter ツールの導入

Lint / Formatter として、[ESLint](https://github.com/eslint/eslint) と [Prettier](https://github.com/prettier/prettier) をいれる。

Prettier と ESLint はベストプラクティスが変わりに変わっているので、何が適切かわからない。  
とりあえず参考記事に従って、**ESLint に Linter**・**Prettier に Formatter** と責務を分けて設定することにする。  
...と思っていたけど、微妙に気に入らない点がいくつか出てきたので Lint と Formatter を両方 ESLint に変える方向性を模索したいと思う。

まずはパッケージを追加。

```shell
yarn add -D -E prettier eslint eslint-config-standard eslint-config-prettier eslint-plugin-import eslint-plugin-n eslint-plugin-promise eslint-plugin-unicorn yarn-run-all @typescript-eslint/parser @typescript-eslint/eslint-plugin
```

### Prettier

先に、Prettier の設定から行う。`.prettierrc.yml` に以下の設定を書き込む。  
（ファイル名は Prettier が認識するものならなんでも良いのだが、個人的な好みで Prettier と ESLint の設定ファイルは YAML を使っている）

```yaml title=".prettierrc.yml"
printWidth: 80
tabWidth: 2
useTabs: false
semi: false
quoteProps: 'as-needed'
singleQuote: true
jsxSingleQuote: true
trailingComma: 'none'
bracketSpacing: true
bracketSameLine: true
arrowParens: 'always'
endOfLine: lf
```

- `printWidth`: 行長さを 80 文字に制限する
- `tabWidth`: インデントをスペース 2 つにする
- `useTabs`: インデントにタブを使うか。false なのでスペースを使う
- `semi`: 末尾のセミコロンをなくす
- `quoteProps`: プロパティ指定時、クオートする
- `singleQuote`: シングルクオートを利用する
- `jsxSingleQuote`: JSX でシングルクオートを利用する
- `trailingComma`: 末尾のカンマを消す
- `bracketSpacing`: `{ hoge: true, piyo: false }` のように角括弧の内側にスペースをいれる
- `bracketSameLine`: HTML で `>` をその行の最後に置く
- `arrowParens`: アロー関数の引数で括弧を必ず入れる
- `endOfLine`: ファイルの改行コードを LF にする

https://prettier.io/docs/en/options.html

### ESLint

次に、ESLint の設定をする。`.eslintrc.yml` に以下の設定を書き込む。

```yaml title=".eslintrc.yml"
env:
  es2020: true
  node: true
extends:
  - standard
  - plugin:@typescript-eslint/recommended
  - plugin:unicorn/recommended
  - prettier
parser: '@typescript-eslint/parser'
parserOptions:
  ecmaVersion: latest
  sourceType: module
  project: ./tsconfig.json
plugins:
  - '@typescript-eslint'
rules:
  '@typescript-eslint/no-explicit-any': off
  '@typescript-eslint/ban-ts-comment': off
  'unicorn/prefer-top-level-await': off
  'unicorn/no-null': off
  'no-console': error
```

- `extends`: 必ず `prettier` は最後にすること
- `rules`
  - `@typescript-eslint/no-explicit-any`: 明示的な `any` を使えるようにする
  - `@typescript-eslint/ban-ts-comment`: `@ts-ignore` を使えるようにする
  - [`unicorn/prefer-top-level-await`](https://github.com/sindresorhus/eslint-plugin-unicorn/blob/main/docs/rules/prefer-top-level-await.md): トップレベルの await を優先しなくする
  - [`unicorn/no-null`](https://github.com/sindresorhus/eslint-plugin-unicorn/blob/main/docs/rules/no-null.md): null を制限することをやめる
  - `no-console`: `console.log` などをエラーとする（あとで winston を導入するため）

`.eslintignore` に除外するファイル・ディレクトリを記述する。

```text title=".eslintignore"
dist
output
node_modules
data
logs
```

https://hisa-tech.site/bestpractice-eslint-and-prettier/

### scripts に lint と lintfix コマンドを追加する

`package.json` の `scripts` に以下を追加する。

```json title="package.json" hl_lines="3-9"
{
  "scripts": {
    "lint": "run-p -c lint:prettier lint:eslint lint:tsc",
    "lint:prettier": "prettier --check src",
    "lint:eslint": "eslint . --ext ts,tsx",
    "lint:tsc": "tsc",
    "fix": "run-s fix:prettier fix:eslint",
    "fix:eslint": "eslint . --ext ts,tsx --fix",
    "fix:prettier": "prettier --write src"
  }
}
```

!!! tip "Commit"

    ```shell
    git commit -am "feat: add linter"
    ```

## ncc を使って 1 ファイルにコンパイル

[@vercel/ncc](https://github.com/vercel/ncc) を使って、1 ファイル + α にコンパイルする。

```shell
yarn add -D -E @vercel/ncc
```

`package.json` の `scripts` に以下を追加する。

```json title="package.json" hl_lines="3-7"
{
  "scripts": {
    "package": "run-s clean compile packing",
    "packing": "ncc build ./dist/main.js -o output/ -m",
    "compile": "tsc -p .",
    "clean": "rimraf dist output"
  }
}
```

!!! tip "Commit"

    ```shell
    git commit -am "feat: add ncc"
    ```

## winston でロギング

[winston](https://github.com/winstonjs/winston) でロギングする。[独自のラッパ](https://gist.github.com/book000/b4c8394fe6a12e6ea640df0c8703eb65) を使う。

```shell
yarn add -D -E winston winston-daily-rotate-file logform cycle
wget -O src/logger.ts https://gist.githubusercontent.com/book000/b4c8394fe6a12e6ea640df0c8703eb65/raw/logger.ts
wget -O src/cycle.d.ts https://gist.githubusercontent.com/book000/b4c8394fe6a12e6ea640df0c8703eb65/raw/cycle.d.ts
```

その後、ESLint のルールに `no-console: error` を、（Dockerfile に `ENV LOG_DIR /data/logs` を）追加する。

!!! tip "Commit"

    ```shell
    git commit -am "feat: winston logging"
    ```

## renovate

以下を `renovate.json` に書き込む。

```json title="renovate.json"
{
  "extends": [
    "config:base"
  ],
  "ignorePresets": [
    ":prHourlyLimit2"
  ],
  "timezone": "Asia/Tokyo",
  "dependencyDashboard": false,
  "automerge": true,
  "branchConcurrentLimit": 0
}
```

## ここまでのテンプレート

```powershell
irm https://gist.github.com/book000/7e5e900d9a6bf249f99804539e056ee3/raw/all.ps1 | iex
```

## 設定ファイル用の JSON Schema を生成

設定ファイルの JSON Schema を TypeScript の型定義から生成する。

```shell
yarn add -D -E typescript-json-schema
```

どのファイルでもよいので、以下のような設定ファイルの型定義を作る。必ず `export` すること。

```typescript
export interface Configuration {
  username: string
  password: string
}
```

`package.json` の `scripts` に以下を追加する。

```json title="package.json" hl_lines="3"
{
  "scripts": {
    "generate-schema": "typescript-json-schema --required tsconfig.json Configuration -o schema/Configuration.json",
  }
}
```

設定ファイルには以下のように JSON Schema を定義できる。

```json title="data/" hl_lines="2"
{
  "$schema": "../schema/Configuration.json"
}
```

!!! tip "Commit"

    ```shell
    git commit -am "feat: add config schema"
    ```

## Docker で動作

[book000/templates](https://github.com/book000/templates) の `node-ncc-app.Dockerfile` と `docker.yml` を使う。

```shell
wget -O Dockerfile https://raw.githubusercontent.com/book000/templates/master/dockerfiles/node-ncc-app.Dockerfile
mkdir -p .github/workflows ; wget -O .github/workflows/docker.yml https://raw.githubusercontent.com/book000/templates/master/workflows/docker.yml
```

- [x] winston を導入している場合、`ENV LOG_DIR /data/logs` を `Dockerfile` に追加すること
- [x] `docker.yml` の `with` にて、`targets` を変更すること

!!! tip "Commit"

    ```shell
    git commit -am "feat: docker"
    ```
