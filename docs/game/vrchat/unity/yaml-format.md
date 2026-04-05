# Unity YAML フォーマット

## 基本構造

Unity の `.prefab`、`.mat`、`.asset`、`.unity` などのテキスト形式アセットは独自拡張 YAML を使う。

```yaml
%YAML 1.1
%TAG !u! tag:unity3d.com,2011:
--- !u!114 &123456789
MonoBehaviour:
  m_ObjectHideFlags: 0
```

`--- !u!{typeID} &{fileID}` でドキュメントを区切る。

- `typeID` は Unity 内部のオブジェクト型 ID（114 は MonoBehaviour）
- `fileID` はファイル内のローカル ID

## アセット GUID

各アセットファイルに対応する `.meta` ファイルが存在し、 `guid` フィールドに 32 桁の 16 進数が記録される。

```yaml
# SomeTexture.png.meta
guid: 9a8f2e4b1c3d5e6f7a8b9c0d1e2f3a4b
```

`.prefab` 等から他アセットを参照する際は以下の形式を使う。

```yaml
- {fileID: 2100000, guid: 9a8f2e4b1c3d5e6f7a8b9c0d1e2f3a4b, type: 2}
```

- `fileID: 2100000` はマテリアルを指す Unity 内部の固定値
- `type: 2` はアセット参照を意味する

## `.meta` ファイルから GUID を取得する

```python
def get_guid(meta_path: str) -> str | None:
    with open(meta_path, encoding="utf-8") as f:
        for line in f:
            if line.startswith("guid:"):
                return line.split(":")[1].strip()
    return None
```

## ruamel.yaml で Unity YAML をパースする

PyYAML などの一般的な YAML パーサーは `!u!` タグで失敗する。ruamel.yaml を使う場合は、パース前にドキュメント開始行を正規化する。

```python
import re
from ruamel.yaml import YAML

def normalize_unity_yaml(text: str) -> str:
    # `--- !u!114 &123` を `---` に置き換える（行数は変えない）
    return re.sub(r"^---\s+!u!\d+\s+&\d+\s*$", "---", text, flags=re.MULTILINE)

yaml = YAML(typ="rt")
yaml.allow_duplicate_keys = True  # Unity YAML は重複キーを持つ場合がある
yaml.preserve_quotes = True

docs = list(yaml.load_all(normalize_unity_yaml(text)))
```

`allow_duplicate_keys = True` を設定しないと、Unity の YAML 出力に含まれる重複キーでパースが失敗する。

`typ="rt"` はラウンドトリップモードで、各フィールドの行番号情報（`lc` 属性）を保持する。特定フィールドだけを書き換えたい場合に使う。

## GUID を参照するファイル形式

以下の拡張子のファイルが GUID による参照を含む。

| 拡張子 | 用途 |
| --- | --- |
| `.prefab` | プレハブ |
| `.unity` | シーン |
| `.mat` | マテリアル |
| `.asset` | ScriptableObject 等 |
| `.anim` | アニメーションクリップ |
| `.controller` | Animator Controller |
| `.overridecontroller` | Animator Override Controller |
| `.shadergraph` | Shader Graph |
| `.timeline` | Timeline |
| `.mixer` | Audio Mixer |
| `.playable` | Playable |
