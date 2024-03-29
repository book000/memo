# 執筆用メモ

## ディレクトリ構成

ドキュメント自体はすべて docs ディレクトリの中に置く。この中のものが mkdocs によってビルド対象となり、デプロイされる。

そのなかで、ある程度カテゴリ分けをしている。

- os: 各 OS ごとの話
  - windows: Windows の話
  - linux: Linux の話
  - ios: iOS の話
  - android: Android の話
- programming: プログラミング。というか各言語固有の話
- etc: それ以外

## 記法

純粋な Markdown の記法以外に、mkdocs（正確には mkdocs-material のようだが…）にも独自記法がある。

https://squidfunk.github.io/mkdocs-material/reference/

### コードブロック

https://squidfunk.github.io/mkdocs-material/reference/code-blocks/

ファイル名など、コードブロックにタイトルをつける場合、言語名の後に `title="タイトル"` とつけるらしい。つまり...

```markdown
```python title="main.py"
```

コードの一部をハイライトする場合は、`hl_lines="2 3"` とかやると 2 行目と 3 行目がハイライトされる。

### インフォメーション・アコーディオン

https://squidfunk.github.io/mkdocs-material/reference/admonitions/

```markdown
!!! note "Lorem ipsum"

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.
```

アコーディオンにする場合は `!!!` を `???` にする。

`note` 以外にも、以下を選べる。

- abstract
- info
- tip
- success
- question
- warning
- failure
- danger
- bug
- example
- quote

### キーストローク

キーボード操作を表記する場合、キー名を `++` で囲む。キー名は小文字。  
たとえば `Enter` を表現するなら `++enter++` で ++enter++。複数キーストロークを表現するなら `++shift+y++` で ++shift+y++ みたいな。

### 画像の配置

文章の後に画像を置いたほうが見やすい気がする。
