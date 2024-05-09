# Tasks for aqua-registry-contributing-helper-scripts

Using [mask](https://github.com/jacobdeichert/mask)

## patch

> Create a patch and copy it to windows

```bash
mask clean
mask diff-patch
mask copy2win-patch
```

## diff-patch

> Create a patch

```bash
PRODUCT_NAME="aqua-registry-contributing-helper-scripts"
DEFAULT_REMOTE="origin"
DEFAULT_BRANCH="master"
TODAY=$(date +'%Y%m%d')
BRANCH_NAME=$(git branch --show-current)

if [[ "$BRANCH_NAME" = "$DEFAULT_BRANCH" ]] || [[ "$BRANCH_NAME" = "patch-"* ]]; then
    echo "This branch is $DEFAULT_BRANCH or patch branch"

    for p in "$PRODUCT_NAME" "." "$TODAY" "." "patch"; do
        PATCH_NAME+=$p
    done
else
    echo "This branch is uniq feat branch"

    for p in "$PRODUCT_NAME" "_" "$BRANCH_NAME" "." "$TODAY" "." "patch"; do
        PATCH_NAME+=$p
    done
fi

echo "patch file name: $PATCH_NAME"
git diff "$DEFAULT_REMOTE/$DEFAULT_BRANCH" >"$PATCH_NAME"
```

## patch-branch

> Create a patch branch

```bash
TODAY=$(date +'%Y%m%d')
git switch -c "patch-$TODAY"
```

## switch-master

> Switch to DEFAULT branch

```bash
DEFAULT_BRANCH="master"
git switch "$DEFAULT_BRANCH"
```

## delete-branch

> Delete patch branch

```bash
mask clean
mask switch-master
git branch --list "patch*" | xargs -n 1 git branch -D
```

## clean

> Run clean

```bash
# patch
rm -f ./*.patch
rm -f ./*.patch.gpg

# zip file
rm -f ./*.zip
```

## copy2win-patch

> Copy patch to Windows

```bash
cp *.patch $WIN_HOME/Downloads/
```

## test

```bash
mask lint
```

## lint

> Run lints

```bash
mask textlint
mask typo-check
mask shell-lint
```

## textlint

> Run textlint

```bash
pnpm run textlint
```

## typo-check

> Run typos

```bash
typos .
```

## shell-lint

> Run shell lint (Linux only)

```bash
shellcheck --shell=bash --external-sources \
	utils/*

shfmt --language-dialect bash --diff \
	./**/*
```

## fmt

```bash
mask format
```

## format

> Run format

```bash
mask shell-format
```

## shell-format

> Run shfmt (Linux only)

```bash
shfmt --language-dialect bash --write \
	./**/*
```

```powershell
Write-Output "Windows is not support!"
```

## changelog

> Add commit message up to `origin/master` to CHANGELOG.md

```bash
RESULT_FILE="CHANGELOG.md"
GIT_LOG=$(git log "origin/master..HEAD" --pretty=format:"%B")

{
    echo "## run"
    echo ""
    echo "$GIT_LOG" | sed -e '/^$/d' | sed -e 's/^/- /g'
    echo ""
    echo '```bash'
    echo 'git commit -m "WIP:--------------------------------------------------------------------------" --allow-empty'
    echo 'git commit -m "WIP:--------------------------------------------------------------------------" --allow-empty'
    echo "$GIT_LOG" | sed -e '/^$/d' | sed -e 's/^/git commit -m "WIP:/g' | sed -e 's/$/" --allow-empty/g'
    echo '```'
    echo ""
} >>$RESULT_FILE
```

## pab

> Create a patch branch (alias)

```bash
mask patch-branch
```

## deleb

> Delete patch branch (alias)

```bash
mask delete-branch
```
