#!/bin/bash

RESULT_FILE="CHANGELOG.md"
GIT_LOG=$(git log "origin/master..HEAD" --pretty=format:"%B")

{
    echo "## run"
    echo ""
    echo '```bash'
    echo 'git commit -m "WIP:--------------------------------------------------------------------------" --allow-empty --no-verify'
    echo "$GIT_LOG" |
        # Remove blank line
        sed -e '/^$/d' |
        # Remove STARTUPTIME.md commit msg
        sed -e 's/.*STARTUPTIME.md.*//g' |
        # Remove DROP commit msg
        sed -e 's/.*DROP.*//g' |
        # Remove blank line
        sed -e '/^$/d' |
        sed -e 's/^/git commit -m "WIP:/g' |
        sed -e 's/$/" --allow-empty --no-verify/g'
    echo 'git commit -m "WIP:--------------------------------------------------------------------------" --allow-empty --no-verify'
    echo '```'
} >>$RESULT_FILE
