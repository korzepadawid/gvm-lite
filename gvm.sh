#!/usr/bin/env bash

# todo: check the recent version and use it by default
DESIRED_GO_VERSION="$1"
GO_INSTALL_DIR="/usr/local/go"


if [ -d "$GO_INSTALL_DIR" ]; then
  echo "Go instalation detected in $GO_INSTALL_DIR.";
  rm -rf $GO_INSTALL_DIR;
  echo "Removed $GO_INSTALL_DIR";
else
    echo "Go not found in $GO_INSTALL_DIR";
fi

echo "Downloading go $DESIRED_GO_VERSION";
wget https://go.dev/dl/go$DESIRED_GO_VERSION.linux-amd64.tar.gz -P /tmp/ -O /tmp/go$DESIRED_GO_VERSION.linux-amd64.tar.gz;
if [ $? -eq 0 ]; then
  echo "Download of go$DESIRED_GO_VERSION.linux-amd64.tar.gz successful";
else
  echo "Download of go$DESIRED_GO_VERSION.linux-amd64.tar.gz failed";
  exit 1
fi

echo "Unpacking /tmp/go$DESIRED_GO_VERSION.linux-amd64.tar.gz";
tar -C /usr/local -xzf /tmp/go$DESIRED_GO_VERSION.linux-amd64.tar.gz;
echo "Go version set to $DESIRED_GO_VERSION.";
echo "You're ready to go!";
