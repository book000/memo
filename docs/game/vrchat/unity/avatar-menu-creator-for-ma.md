# AvatarMenuCreatorForMA の選択式メニュー

[AvatarMenuCreatorForMA](https://github.com/Narazaka/AvatarMenuCreaterForMA)（作者: Narazaka）は、Modular Avatar を利用して VRChat アバターのメニューを非破壊で作成する Unity ツール。ON/OFF・選択式・無段階調整の 3 種類のメニューを生成できる。

衣装の色切り替えなど「複数の選択肢から 1 つを選ぶ」場面では**選択式メニュー**（`AvatarChooseMenuCreator` コンポーネント）を使う。

## prefab に保存されるデータ構造

`AvatarChooseMenuCreator` コンポーネントが持つ `AvatarChooseMenu` フィールドに選択肢の設定が記録される。Unity YAML では以下のように展開される。

```yaml
MonoBehaviour:
  AvatarChooseMenu:
    ChooseCount: 3
    ChooseDefaultValue: 0
    ChooseNames:
      keys: 000000000100000002000000
      values:
      - Black
      - Blue
      - Pink
    ChooseMaterials:
      keys1: []
      keys2: ''
      values:
      - keys: 000000000100000002000000
        values:
        - {fileID: 2100000, guid: aaa..., type: 2}
        - {fileID: 2100000, guid: bbb..., type: 2}
        - {fileID: 2100000, guid: ccc..., type: 2}
    ChooseObjects:
      keys: ''
      values: []
    ChooseBlendShapes:
      keys1: []
      keys2: ''
      values: []
```

### 主なフィールド

| フィールド | 型 | 説明 |
| --- | --- | --- |
| `ChooseCount` | int | 選択肢の総数 |
| `ChooseDefaultValue` | int | デフォルト選択肢のインデックス（0 始まり） |
| `ChooseNames` | IntStringDictionary | インデックス → 選択肢名（VRChat メニューに表示される） |
| `ChooseMaterials` | ChooseMaterialDictionary | マテリアルスロットごとの、選択肢順マテリアル参照リスト |
| `ChooseObjects` | IntHashSetDictionary | 選択肢ごとにアクティブにする GameObject パス集合 |
| `ChooseBlendShapes` | ChooseBlendShapeDictionary | 選択肢ごとの BlendShape 値 |
| `ChooseShaderParameters` | ChooseBlendShapeDictionary | 選択肢ごとのシェーダーパラメーター値 |

`ChooseNames` と `ChooseMaterials.values[*]` の内部データ形式は `SerializedDictionary` のシリアライズ形式に従い、`keys` フィールドにインデックスの一覧、`values` に対応する値の一覧を持つ。

## keys フィールドのエンコード規則

`ChooseNames.keys` や `ChooseMaterials.values[*].keys` に使われる文字列。`SerializedDictionary` が Unity にシリアライズされる際のキー配列表現で、インデックス `i` を `f"{i:02x}000000"` の 8 文字ブロックに変換して連結する。

`make_key(n)` は 0 から n までの n+1 個の要素を生成する。`make_key_for_count(count)` は `make_key(count - 1)` を呼ぶことで、ちょうど count 個の要素に対応するキー文字列を返す。

```python
def make_key(n: int) -> str:
    return "".join(f"{i:02x}" + "000000" for i in range(n + 1))

def make_key_for_count(count: int) -> str:
    if count <= 0:
        return ""
    return make_key(count - 1)
```

| 要素数 | keys |
| --- | --- |
| 1 | `00000000` |
| 2 | `0000000001000000` |
| 3 | `000000000100000002000000` |

パターンは `{i:02x}000000` の連結（i = 0 から count-1）。

## prefab を安全に書き換える方法

AvatarMenuCreatorForMA が生成した prefab をスクリプトで更新する場合、ファイル全体を再ダンプせず対象行のみを差し替えることでフォーマットが崩れるのを防ぐ。

1. ruamel.yaml の `typ="rt"` でパースし、 `lc` 属性から各フィールドの行番号を取得する
2. 元テキストの該当行を直接書き換える
3. 複数箇所を書き換える場合は行番号の降順で適用し、行ズレを防ぐ
4. 初回書き込み前に `.bak` バックアップを作成しておく

```python
from ruamel.yaml import YAML
import re

yaml = YAML(typ="rt")
yaml.allow_duplicate_keys = True
yaml.preserve_quotes = True

parse_text = re.sub(r"^---\s+!u!\d+\s+&\d+\s*$", "---", text, flags=re.MULTILINE)
docs = list(yaml.load_all(parse_text))
lines = text.splitlines(keepends=True)

menu = docs[1]["MonoBehaviour"]["AvatarChooseMenu"]
line_no = menu.lc.key("ChooseCount")
lines[line_no] = f"    ChooseCount: {new_count}\n"

with open(prefab_path, "w", encoding="utf-8", newline="") as f:
    f.write("".join(lines))
```

## YAML スカラーのクォート判定

色名を YAML に書き込む際、スペースや日本語を含む場合はダブルクォートで囲む必要がある。

```python
import re

def yaml_quote_scalar(s: str) -> str:
    if s == "":
        return '""'
    # ASCII 英数字・_ . / - 以外を含む場合はクォート
    if re.search(r"[^0-9A-Za-z_./\-]", s):
        escaped = s.replace("\\", "\\\\").replace('"', '\\"')
        return f'"{escaped}"'
    return s
```

## マテリアルの構造パターン

衣装フォルダ内のマテリアル配置には 3 パターンある。

### パターン 1: Color フォルダ

```
Material/
├── Color01/
│   ├── Body.mat
│   └── Body.mat.meta
└── Color02/
    └── ...
```

### パターン 2: 色名フォルダ

```
Material/
├── Blue/
│   ├── Body_Blue.mat
│   └── Body_Blue.mat.meta
└── Pink/
    └── ...
```

### パターン 3: フラット + 色サフィックス

```
Materials/
├── Body_Blue.mat
├── Body_Blue.mat.meta
├── Body_Pink.mat
└── ...
```

いずれのパターンも、`.mat.meta` ファイルを走査して `guid:` 行を読み取ることで GUID を抽出できる。フラット構造の場合はファイル名の最後のアンダースコア以降を色名として扱う。

## マテリアル情報の整理例

各マテリアル種別と色の対応は以下のように整理すると扱いやすい。

```text
  Jersey (000000000100000002000000):
        - {fileID: 2100000, guid: <Black の GUID>, type: 2}
        - {fileID: 2100000, guid: <Blue の GUID>, type: 2}
        - {fileID: 2100000, guid: <Pink の GUID>, type: 2}
```
