#!/usr/bin/env bash

add_to_shell_config() {
  local shell_config_file=$1
  local path_to_add="/usr/local/go/bin"

  if grep -q "export PATH=.*$path_to_add" "$shell_config_file"; then
    echo "Path already exists in $shell_config_file"
  else
    echo "export PATH=\$PATH:$path_to_add" >> "$shell_config_file"
    echo "Path added to $shell_config_file"
  fi
}

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

if grep -q "export PATH=.*\/usr\/local\/go\/bin" /etc/profile; then
  echo "/usr/local/go/bin is already in /etc/profile"
else
  if [ -n "$BASH_VERSION" ]; then
    shell_config_file="$HOME/.bashrc"
  elif [ -n "$ZSH_VERSION" ]; then
    shell_config_file="$HOME/.zshrc"
  else
    shell_config_file="$HOME/.profile"
  fi

  if [ ! -f "$shell_config_file" ]; then
    touch "$shell_config_file"
  fi

  add_to_shell_config "$shell_config_file"

  source "$shell_config_file"
fi

echo "You're ready to go!";
