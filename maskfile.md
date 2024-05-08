# aqua-registry contributing helper maskfile

## prepare (ar_user_name) (ar_repo_name)

> Set fish universal vars

```fish
set -Ux AR_USER_NAME $ar_user_name
set -Ux AR_REPO_NAME $ar_repo_name
```

## print

> Print env vars

```fish
echo "$AR_USER_NAME"
echo "$AR_REPO_NAME"
```

## reset

> Reset fish universal vars

```fish
set -e AR_USER_NAME
set -e AR_REPO_NAME
```

## pab

> Create patch branch

```bash
USER_NAME="mattn"
REPO_NAME="sleepy"
BRANCH_NAME="feat/$USER_NAME/$REPO_NAME"
git branch "$BRANCH_NAME"
```

## commit

> Create empty commit

```bash
USER_NAME="mattn"
REPO_NAME="sleepy"
git commit -m "feat: add $USER_NAME/$REPO_NAME" --allow-empty --no-verify
```

## clean

> Delete unused files

```bash
rm -f ./*.patch
rm -f ./*.zip
```

## diff-patch

> Create a patch

```bash
PRODUCT_NAME="aqua-registry"
DEFAULT_REMOTE="origin"
DEFAULT_BRANCH="main"
TODAY=$(date +'%Y%m%d')
REPLACED_BRANCH_NAME=$(git branch --show-current | sed -e "s/\//_/g")

for p in "$PRODUCT_NAME" "_" "$REPLACED_BRANCH_NAME" "." "$TODAY" "." "patch"; do
    PATCH_NAME+=$p
done

echo "patch file name: $PATCH_NAME"
git diff "$DEFAULT_REMOTE/$DEFAULT_BRANCH" >"$PATCH_NAME"
```

## patch

> Create patch file and copy to windows

```bash
mask clean
mask diff-patch
cp *.patch $WIN_HOME/Downloads/
```
