# ColorSelector prefab の構造

VRChat アバターで衣装の色を切り替える仕組みに使われる Unity prefab の構造。

## YAML 構造

```yaml
MonoBehaviour:
  AvatarChooseMenu:
    ChooseCount: 3
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
```

- `ChooseCount` は選択肢の数
- `ChooseNames.values` は色名の一覧（UI に表示される）
- `ChooseMaterials.values` はマテリアルグループの一覧で、各グループの `values` に色順でマテリアル参照を並べる

## keys フィールドのエンコード規則

`ChooseNames.keys` と `ChooseMaterials.values[*].keys` に使われる文字列。要素数 n に対して、0 から n-1 までの連番を 8 桁 16 進数ブロックで連結する。

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

ファイル全体を再ダンプせず、対象行のみを差し替えることでフォーマットが崩れるのを防ぐ。

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
