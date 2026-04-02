# VRChat アバター操作

## アバター一覧の全件取得

`search_avatars` は 1 回のリクエストで最大 100 件しか取得できない。全件取得するにはオフセットを進めながらページングする。

```python
from vrchatapi.api.avatars_api import AvatarsApi

avatar_api = AvatarsApi(api_client)

avatars = []
offset = 0
while True:
    results = avatar_api.search_avatars(
        user="me", sort="name", n=100,
        release_status="all", offset=offset
    )
    if not results:
        break
    avatars.extend(results)
    offset += len(results)
```

## サムネイル画像の更新

画像をアップロードし、取得した URL を `update_avatar` でアバターに紐づける。

```python
from vrchatapi.api.files_api import FilesApi

files_api = FilesApi(api_client)
file = files_api.upload_image(file_path, "avatarimage")

# 最新バージョンの URL を取得
latest_version = max(file.versions, key=lambda v: v.version)
url = latest_version.file.url

avatar_api.update_avatar(
    avatar_id,
    update_avatar_request={"imageUrl": url},
)
```

## レート制限への対応

VRChat API は頻繁なリクエストに対して HTTP 429 を返す。 `Retry-After` ヘッダーに指定された秒数を待ってからリトライする。

```python
from vrchatapi.rest import ApiException
import time

while True:
    try:
        result = api_call()
        break
    except ApiException as e:
        if e.status == 429:
            retry_after = e.headers.get("Retry-After")
            wait = int(retry_after) + 5 if retry_after else 60
            time.sleep(wait)
        else:
            raise
```

アップロードとサムネイル更新の両方で 429 が発生しうるため、それぞれにリトライ処理を実装する。

## 差分チェックで不要アップロードを削減

既存のサムネイルをダウンロードして新画像とピクセル単位で比較し、差分がない場合はアップロードをスキップする。

```python
import os
import urllib.request
from PIL import Image

def download_file(url: str, dst_path: str) -> None:
    req = urllib.request.Request(url, headers={"User-Agent": "MyApp (author, v1.0.0)"})
    with urllib.request.urlopen(req) as web_file, open(dst_path, "wb") as local_file:
        local_file.write(web_file.read())

def is_image_different(path1: str, path2: str) -> bool:
    img1 = Image.open(path1).convert("RGBA")
    img2 = Image.open(path2).convert("RGBA")
    if img1.size != img2.size:
        img2 = img2.resize(img1.size, Image.LANCZOS)
    return any(p1 != p2 for p1, p2 in zip(img1.getdata(), img2.getdata()))

download_file(avatar.image_url, existing_path)
if not is_image_different(new_image_path, existing_path):
    os.remove(existing_path)
    continue  # 変更なし、スキップ
os.remove(existing_path)
```

## サムネイルへのオーバーレイ合成

Pillow を使って画像の特定位置にテキストや画像を合成する。

```python
from PIL import Image, ImageDraw, ImageFont

def insert_text(
    file_path: str,
    text: str,
    font: ImageFont.FreeTypeFont,
    color: tuple = (255, 255, 255),
    position: str = "top_right",
    x_padding: int = 10,
    y_padding: int = 10,
) -> None:
    image = Image.open(file_path)
    draw = ImageDraw.Draw(image)
    text_width = draw.textlength(text, font=font)
    text_height = font.getbbox(text)[3] - font.getbbox(text)[1]

    if position == "top_right":
        x = image.width - text_width - x_padding
        y = y_padding
    elif position == "bottom_right":
        x = image.width - text_width - x_padding
        y = image.height - text_height - (y_padding * 2)
    # 他の位置は同様に実装

    draw.text((x, y), text, font=font, fill=color)
    image.save(file_path)
```

サムネイルに付与する情報の例。

| 位置 | 内容 |
| --- | --- |
| 左上 | アバタービルドバリアント（Full / Light / Slim など） |
| 右上 | バージョン（v0 〜） |
| 右下 | Performance Rank アイコン |

Performance Rank の値は `avatar.performance.standalonewindows` から取得でき、 `excellent`、 `good`、 `medium`、 `poor`、 `very_poor` のいずれかになる。

## アバター名のパース

Unity プロジェクトでのアバター管理に命名規則を設けると、コードで種別・バージョンを自動判別できる。

```
{ベース名}_{バージョン}-{サフィックス} {表示名}  例: Milk_v3-Full ミルク
{ベース名}_{バージョン} {表示名}                 例: Milk_v3 ミルク
{ベース名} {表示名}                              例: Milk ミルク
```

```python
import re

def parse_avatar_name(name: str) -> dict:
    patterns = [
        r"^(?P<base>.+)_(?P<version>v\d+)-(?P<suffix>.+?)\s(?P<display>.+)$",
        r"^(?P<base>.+)_(?P<version>v\d+)\s(?P<display>.+)$",
        r"^(?P<base>.+)\s(?P<display>.+)$",
    ]
    for pattern in patterns:
        match = re.match(pattern, name)
        if match:
            return match.groupdict()
    raise ValueError(f"Invalid avatar name format: {name}")
```

サフィックスはアバターのビルドバリアント（Full / Light / Slim など）を表すために使える。
