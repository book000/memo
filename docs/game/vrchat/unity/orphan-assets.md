# 孤立アセットの検出と除去

Unity プロジェクト内で参照されていないアセット（孤立アセット）を検出する手順。

## 基本的な考え方

1. 全 `.meta` ファイルから `guid → アセットパス` のマップを構築する
2. GUID 参照を含むファイル群から参照グラフを構築する
3. Build Settings のシーンなどをルートとして BFS でグラフを辿り、到達可能なアセットを求める
4. 到達不能なアセット = 孤立アセット

## 到達可能なアセットのルート

- `ProjectSettings/EditorBuildSettings.asset` に含まれる有効なシーン
- `Assets/AddressableAssetsData/` 配下の Addressables エントリ
- 上記が 0 件の場合、 `Assets/` 配下の全 `.unity` ファイルをフォールバックとして使う

## 除外すべきディレクトリ

以下のディレクトリは動的参照や特殊な扱いをされるため、孤立扱いにしない。

| ディレクトリ | 理由 |
| --- | --- |
| `Assets/Resources` | `Resources.Load()` で動的参照される |
| `Assets/StreamingAssets` | パス文字列で直接参照される |
| `Assets/Editor` | エディタ専用（ビルドに含まれない） |
| `Assets/Plugins` | プラグイン |

## 保護すべき拡張子

スクリプトやシェーダー類は参照グラフに現れなくても削除してはならない。

`.cs` `.asmdef` `.asmref` `.dll` `.shader` `.cginc` `.hlsl` `.compute`

## Unity Editor スクリプトによる到達可能アセットのダンプ

`AssetDatabase.GetDependencies()` を使えば Unity 内部の依存解決を利用できる。

```csharp
[MenuItem("Tools/Dump Reachable Assets")]
public static void DumpFromMenu()
{
    var roots = EditorBuildSettings.scenes
        .Where(s => s.enabled && !string.IsNullOrEmpty(s.path))
        .Select(s => s.path)
        .ToArray();

    // ルートが 0 件の場合は全シーンをフォールバックとして使う
    if (roots.Length == 0)
    {
        roots = AssetDatabase.FindAssets("t:Scene", new[] { "Assets" })
            .Select(AssetDatabase.GUIDToAssetPath)
            .ToArray();
    }

    var deps = AssetDatabase.GetDependencies(roots, recursive: true);
    File.WriteAllLines("reachable_paths.txt", deps.OrderBy(x => x));
}
```

Addressables が導入されている場合は `AddressableAssetSettingsDefaultObject.Settings.GetAllAssets()` を Reflection 経由で呼び出すことで、Addressables エントリもルートに含められる。Addressables 未導入環境でもコンパイルできるよう、 `Type.GetType()` で存在確認してから使う。

## Python による孤立アセット検出

Unity Editor を起動せずに Python のみで検出する方法。

```python
import os, re
from pathlib import Path
from collections import deque

GUID_RE = re.compile(r"guid:\s*([0-9a-fA-F]{32})")
GUID_TEXT_EXTS = {
    ".prefab", ".unity", ".mat", ".asset", ".anim",
    ".controller", ".overridecontroller", ".shadergraph",
    ".timeline", ".mixer", ".playable",
}

def collect_guid_map(assets_dir: Path) -> dict[str, str]:
    guid_map = {}
    for meta in assets_dir.rglob("*.meta"):
        text = meta.read_text(encoding="utf-8", errors="ignore")
        m = GUID_RE.search(text)
        if m and meta.with_suffix("").is_file():
            guid_map[m.group(1).lower()] = str(meta.with_suffix(""))
    return guid_map

def compute_reachable(roots: list[str], graph: dict[str, set[str]]) -> set[str]:
    reachable = set(roots)
    q = deque(reachable)
    while q:
        node = q.popleft()
        for nxt in graph.get(node, ()):
            if nxt not in reachable:
                reachable.add(nxt)
                q.append(nxt)
    return reachable
```

この方法は Unity Editor を使わないため、Addressables の解決精度が落ちる。正確な結果が必要な場合は Unity Editor 側でダンプしたファイル（`reachable_paths.txt`）を外部入力として取り込む。

## 孤立アセットの処理方法

削除ではなく専用ディレクトリへの移動が安全。 `Assets/AssetOrphaneds/{タイムスタンプ}/` へ `.meta` ファイルと一緒に移動する。Unity の参照は GUID ベースのため、GUID が変わらない限り既存の参照は壊れない。本当に不要であることを確認した後、まとめて削除する。

`.meta` ファイルも必ずセットで移動する。
