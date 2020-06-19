#!/bin/sh

echo "Cloning CodeReady Workspaces Devfile Registry"

git clone git@github.com:redhat-developer/codeready-workspaces.git

echo "Copying OptaPlanner Workshop Devfile"
pushd codeready-workspaces/dependencies/che-devfile-registry/devfiles
cp -R ../../../../che-devfile-registry/devfiles/* .
popd

pushd codeready-workspaces/dependencies/che-devfile-registry/images
cp ../../../../che-devfile-registry/images/* .
popd

pushd codeready-workspaces/dependencies/che-devfile-registry
docker build -t che-devfile-registry -f build/dockerfiles/Dockerfile .
docker tag che-devfile-registry quay.io/ddoyle/che-devfile-registry
docker push quay.io/ddoyle/che-devfile-registry
popd

rm -rf codeready-workspaces

