# VRChat API 認証

## 使用ライブラリ

PyPI で公開されている非公式 Python クライアント `vrchatapi` を使う。

```bash
pip install vrchatapi
```

## ログインフロー

`vrchatapi.Configuration` にユーザー名とパスワードをセットし、 `get_current_user()` を呼ぶ。

```python
import vrchatapi
from vrchatapi.api import authentication_api
from vrchatapi.models.two_factor_auth_code import TwoFactorAuthCode
from vrchatapi.models.two_factor_email_code import TwoFactorEmailCode
from vrchatapi.exceptions import UnauthorizedException

configuration = vrchatapi.Configuration(username="user", password="pass")

with vrchatapi.ApiClient(configuration) as api_client:
    api_client.user_agent = "MyApp (author, v1.0.0)"
    auth_api = authentication_api.AuthenticationApi(api_client)
    try:
        current_user = auth_api.get_current_user()
    except UnauthorizedException as e:
        if e.status == 200:
            if "Email 2 Factor Authentication" in e.reason:
                auth_api.verify2_fa_email_code(
                    TwoFactorEmailCode(input("Email 2FA Code: "))
                )
            elif "2 Factor Authentication" in e.reason:
                auth_api.verify2_fa(
                    TwoFactorAuthCode(input("2FA Code: "))
                )
            current_user = auth_api.get_current_user()
```

`User-Agent` は VRChat の利用規約に基づき必ず設定する。

2FA が設定されているアカウントでは、 `get_current_user()` が HTTP ステータス 200 のまま `UnauthorizedException` を投げる。エラーではなく MFA チャレンジなので、ステータスが 200 かどうかで判別する。

2FA の種別は `e.reason` の文字列で判断する。

- `"Email 2 Factor Authentication"` を含む → メール 2FA
- `"2 Factor Authentication"` のみ → TOTP 2FA

## セッション Cookie の保存と再利用

ログイン成功後、 `auth` と `twoFactorAuth` の 2 つの Cookie を保存すれば、次回起動時に ID/PW ログインをスキップできる。

```python
from http.cookiejar import Cookie
import json

# ログイン後に Cookie を取り出す
cookie_jar = api_client.rest_client.cookie_jar._cookies["api.vrchat.cloud"]["/"]
auth = cookie_jar["auth"].value
two_factor_auth = cookie_jar["twoFactorAuth"].value

# JSON ファイルに保存する
with open("credentials.json", "w") as f:
    json.dump({"auth": auth, "twoFactorAuth": two_factor_auth}, f)
```

次回起動時に Cookie を復元する。

```python
def make_cookie(name: str, value: str) -> Cookie:
    return Cookie(
        0, name, value, None, False,
        "api.vrchat.cloud", True, False,
        "/", False, False,
        173106866300,
        False, None, None, {},
    )

with open("credentials.json") as f:
    credentials = json.load(f)

api_client.rest_client.cookie_jar.set_cookie(make_cookie("auth", credentials["auth"]))
api_client.rest_client.cookie_jar.set_cookie(
    make_cookie("twoFactorAuth", credentials["twoFactorAuth"])
)
```

Cookie が無効になった場合は `UnauthorizedException` が発生する。その場合のみ ID/PW で再ログインするフォールバックを用意しておく。

```python
if os.path.exists("credentials.json"):
    with open("credentials.json") as f:
        credentials = json.load(f)
    try:
        return login_with_cookies(credentials["auth"], credentials["twoFactorAuth"])
    except UnauthorizedException:
        pass  # Cookie 期限切れ → ID/PW ログインへ

credentials = login_with_credentials()
with open("credentials.json", "w") as f:
    json.dump(credentials, f)
```
