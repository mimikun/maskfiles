# Tasks for healthy-person-emulator-dotorg

Using [mask](https://github.com/jacobdeichert/mask)

## patch

> Create a patch and copy it to windows

```bash
mask diff-patch
mask copy2win-patch
```

## diff-patch

> Create a patch

```bash
PRODUCT_NAME="healthy-person-emulator-dotorg"
DEFAULT_REMOTE="origin"
DEFAULT_BRANCH="main"
TODAY=$(date +'%Y%m%d')

for p in "$PRODUCT_NAME" "." "$TODAY" "." "patch"; do
    PATCH_NAME+=$p
done

echo "patch file name: $PATCH_NAME"
git diff "$DEFAULT_REMOTE/$DEFAULT_BRANCH" >"$PATCH_NAME"
```

## copy2win-patch

> Copy patch to Windows

```bash
cp *.patch $WIN_HOME/Downloads/
```

## changelog

> Add commit message up to `origin/main` to maskfile.md

```bash
GIT_LOG=$(git log "origin/main..HEAD" --pretty=format:"%B")

{
    echo ""
    echo "## run"
    echo ""
    echo '```bash'
    echo 'git commit -m "WIP:--------------------------------------------------------------------------" --allow-empty --no-verify'
    echo "$GIT_LOG" |
        # Remove blank line
        sed -e '/^$/d' |
        # Remove DROP commit msg
        sed -e 's/.*DROP.*//g' |
        # Remove renovate commit
        sed -e 's/.*chore(deps): update dependency.*//g' |
        # Remove blank line
        sed -e '/^$/d' |
        sed -e 's/^/git commit -m "WIP:/g' |
        sed -e 's/$/" --allow-empty --no-verify/g'
    echo 'git commit -m "WIP:--------------------------------------------------------------------------" --allow-empty --no-verify'
    echo '```'
    echo ""
} >> "maskfile.md"
```
