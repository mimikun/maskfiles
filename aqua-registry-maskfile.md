# aqua-registry contributing helper maskfile

## prepare (ar_user_name) (ar_repo_name)

> Set fish universal vars

```fish
set -Ux AR_USER_NAME $ar_user_name
set -Ux AR_REPO_NAME $ar_repo_name
set -Ux AR_PKG_NAME "$ar_user_name/$ar_repo_name"
```

## print-env

> Print env vars

```fish
echo "$AR_USER_NAME"
echo "$AR_REPO_NAME"
echo "$AR_PKG_NAME"
echo "$ar_pkg_yaml"
echo "$ar_reg_yaml"
```

## reset-env

> Reset fish universal vars

```fish
set -e AR_USER_NAME
set -e AR_REPO_NAME
set -e AR_PKG_NAME
set -e ar_pkg_yaml
set -e ar_reg_yaml
```

## pab

```fish
mask patch-branch
```

## commit

> Create empty commit

```fish
git commit -m "feat: add $AR_PKG_NAME" --allow-empty --no-verify
```

## clean

> Delete unused files

```fish
rm -f ./*.patch
rm -f ./*.zip
```

## diff-patch

> Create a patch

```fish
set -x PRODUCT_NAME "aqua-registry"
set -x DEFAULT_REMOTE "upstream"
set -x DEFAULT_BRANCH "main"
set -x TODAY (date +'%Y%m%d')
set -x REPLACED_BRANCH_NAME (git branch --show-current | sed -e "s/\//_/g")

set -x PATCH_NAME "aqua-registry_$REPLACED_BRANCH_NAME.$TODAY.patch"

echo "patch file name: $PATCH_NAME"
git diff "$DEFAULT_REMOTE/$DEFAULT_BRANCH" >"$PATCH_NAME"
```

## patch

> Create patch file and copy to windows

```fish
mask clean
mask diff-patch
cp *.patch $WIN_HOME/Downloads/
```

## format

> Run format

```fish
npx prettier -w registry.yaml
```

## fmt

```fish
mask format
```

## patch-branch

> Create patch branch

```fish
git switch -c "feat/$AR_PKG_NAME"
mask commit
```

---

## set-env

> Set filename in envs

```fish
set -Ux ar_pkg_yaml "pkgs/$AR_PKG_NAME/pkg.yaml"
set -Ux ar_reg_yaml "pkgs/$AR_PKG_NAME/registry.yaml"
```

## scaffold

> Run scaffold

```fish
cmdx scaffold "$AR_PKG_NAME"
mask set-env
```

## test

> Run test

```fish
cmdx test "$AR_PKG_NAME"
```

## before-pr

> Run before pr

```fish
cmdx generate-registry
```

## create-pr

> Run create PR

```fish
# check home or work
if test (hostname) = "TanakaPC"
    echo "This is Work-PC. Can't create PR!"
else
    mask before-pr
    cmdx new "$AR_PKG_NAME"
end
```

## stop

> Stop development docker container

```fish
cmdx stop
```
