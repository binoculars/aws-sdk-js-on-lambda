#!/usr/bin/env bash

set -e

SOURCE_BRANCH="develop"
TARGET_BRANCH="master"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    exit 0
fi

git checkout $TARGET_BRANCH
git merge $SOURCE_BRANCH
git push origin $TARGET_BRANCH
