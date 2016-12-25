#!/usr/bin/env bash

set -e

SOURCE_BRANCH="master"
TARGET_BRANCH="develop"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    exit 0
fi

git checkout -b $TARGET_BRANCH || git checkout $TARGET_BRANCH

REMOTE_VERSION=`cat remote_version`
yarn upgrade aws-sdk@$REMOTE_VERSION
yarn version --new-version $REMOTE_VERSION

# Now let's go have some fun with the cloned repo
#git config user.name "Travis CI"
#git config user.email "$COMMIT_AUTHOR_EMAIL"
#
## If there are no changes to the compiled out (e.g. this is a README update) then just bail.
#if [ -z `git diff --exit-code` ]; then
#    echo "No changes to the output on this push; exiting."
#    exit 0
#fi
#
## Commit the "changes", i.e. the new version.
## The delta will show diffs between new and old versions.
#git add .
#git commit -m "Deploy to GitHub Pages: ${SHA}"
#
#chmod 600 deploy_key
#eval `ssh-agent -s`
#ssh-add deploy_key
#
## Now that we're all set up, we can push.
#git push $SSH_REPO $TARGET_BRANCH
