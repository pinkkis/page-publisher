#!/bin/bash

set -e
set -o pipefail

REF=$1
if [ -z $1 ]; then
    REF='master'
fi

if [ -z "${TARGET_REPO}" ]; then
  TARGET_REPO=${GITHUB_REPOSITORY}
fi

REMOTE_REPO="https://${GITHUB_TOKEN}@github.com/${TARGET_REPO}.git"

cd "${GITHUB_WORKSPACE}" || exit 1
git submodule update --init --recursive

rm -rf .git

if [ -e "yarn.lock" ]; then
  echo "Installing and building using Yarn."
  yarn install && yarn run build
else
  echo "Installing and building using NPM."
  npm install && npm run build
fi

cd dist
touch .nojekyll

if [ -z "${CNAME}" ]; then
    echo "No CNAME present"
else
    echo ${CNAME} > CNAME
fi

git init
git config user.name "${GITHUB_ACTOR}" && git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git add . && git commit -m 'Deployed From Action For $GITHUB_SHA"'
git push --force $REMOTE_REPO master:$REF
rm -rf .git
cd..

echo "Done."
