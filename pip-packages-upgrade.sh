#!/bin/bash
# pipのパッケージを全部アップデートする

# venvに入っていることを確認。

# ----- package update ----- #
# 別手法: pip list -oの出力から取る。これは依存関係のバージョン制限を無視する可能性がある
# pip list -o | tail -n +3 | awk '{ print $1 }' | xargs python -m pip install -U

# pipdeptreeを用いて依存の最上位をアップデートする
pip install -U pipdeptree
pipdeptree -f | sed -r 's/^ .+//g' | sed -r 's/==.*//g' | sed '/^$/d' | xargs python -m pip install -U

# ----- output requirements.txt ----- #
# 別手法: pipreqsを用いて使用中のパッケージだけを吐きだす。これはmypyなどプログラム上では使用していないパッケージを無視する可能性がある
#pip install pipreqs
#pipreqs --encoding UTF8 --print | sort | sed 's/==/~=/g' > requirements.txt

# pipdeptreeを用いてrequirements.txtを吐きだす
pipdeptree -f | sed 's/==/~=/g' > requirements.txt
# 依存最上位パッケージだけならこれ。ただしこれはrequestsなどのパッケージで依存の下にある場合におかしくなるかも
pipdeptree -f | sed -r 's/^ .+//g' | sed '/^$/d' | sed 's/==/~=/g' | sort > requirements.txt
