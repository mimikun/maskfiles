# aqua-registry-contributing-helper-scripts

完全に自分専用

## aquaの人のこだわりガイドライン

- プルリクを開いたあとは `force push` するな

## 初期設定

どこでも可能

```fish
set -Ux hoge (pwd)
# cd use gcd
gcd <aqua-registry>
# copy maskfile
cp $hoge/pr-helper.md maskfile.md
# prepare
mask prepare
# create patch branch
mask pab
# create empty commit
mask commit
```

## Pull-Req 準備

どこでも可能

```fish
# 1 scaffold
mask scaffold
# 2 生成されたファイルを手で直す
vim $ar_pkg_yaml
vim $ar_reg_yaml
# 3 テスト実行
mask test
# 4 OKになるまで2と3を繰り返す
# 5 プルリク作成 特定環境では作成されない
mask create-pr
# 6 dockerコンテナを止める
mask stop
```
