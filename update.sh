#!/usr/bin/env bash

set -e

SOURCE_BRANCH="master"
TARGET_BRANCH="develop"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    exit 0
fi

git checkout -b $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH

REMOTE_VERSION=$(<remote_version)
yarn upgrade aws-sdk@$REMOTE_VERSION
git commit -am "Upgrade aws-sdk version"
yarn version --new-version $REMOTE_VERSION

REPO=`git config remote.origin.url`
SSH_REPO=${REPO/https:\/\/github.com\//git@github.com:}
chmod 600 deploy_key
eval `ssh-agent -s`
ssh-add deploy_key

git push $SSH_REPO $TARGET_BRANCH
git push $SSH_REPO --tags
