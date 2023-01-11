import os
import re
import subprocess


def remove_color(str: str):
  # \x1b[32;1m などを削除する
  return re.sub(r"\x1b\[[0-9;]*m", "", str)


def get_app_info(app: str):
    try:
        result = subprocess.run(["scoop", "info", app], capture_output=True, shell=True, text=True)
        result.check_returncode()
        lines = {}
        for line in result.stdout.splitlines():
          if ":" not in line:
            continue
          lines[remove_color(line.split(":")[0].strip()).lower()] = remove_color(":".join(line.split(":")[1:]).strip())
        return lines
    except subprocess.CalledProcessError:
        return None


def get_app_bucket(app: str):
  info = get_app_info(app)
  if info is None:
    return None
  if "bucket" not in info:
    return None

  return info["bucket"]


def get_scoop_apps_from_text(text: str):
  # `scoop install 7zip` (main bucket)
  # 7zipとmainを取得する

  regex = re.compile(r"`scoop install ([^`]+)` \(([^)]+) bucket\)")

  apps = {}
  for line in text.splitlines():
    match = regex.search(line)
    if match is None:
      continue
    apps[match.group(1)] = match.group(2)

  return apps

def replace_scoop_bucket(text: str, app: str, bucket: str):
  regex = re.compile(r"`scoop install " + app + "` \(([^)]+) bucket\)")

  return regex.sub("`scoop install " + app + "` (" + bucket + " bucket)", text)


# scoop install コマンドの bucket が正しいかを確認する
def main():
  if not os.path.exists("docs/os/windows/installed-softwares.md"):
    print("Not found docs/os/windows/installed-softwares.md")
    return

  with open("docs/os/windows/installed-softwares.md", "r", encoding="utf-8") as f:
    text = f.read()
    apps = get_scoop_apps_from_text(text)

  for app in apps.keys():
    prev_bucket = apps[app]
    bucket = get_app_bucket(app)
    if bucket is None:
      print("WARN: Not found bucket: " + app)
      continue

    print(app, prev_bucket, bucket)
    text = replace_scoop_bucket(text, app, bucket)

  with open("docs/os/windows/installed-softwares.md", "w", encoding="utf-8") as f:
    f.write(text)

if __name__ == "__main__":
  main()