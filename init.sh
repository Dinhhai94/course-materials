#!/bin/sh

shell=bash;

# Detect shell variant
if [ -f ~/.zshrc ]; then
  shell=zsh;
elif [ ! -f ~/.bashrc ]; then
  # add .bashrc if needed
  touch ~/.bashrc;
fi

# Install latest node and npm versions
if [ $(which python) ]; then
  # Install NVM (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | $shell;

  # Initialize NVM
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  nvm install node;
elif [ ! $(which node) ]; then
  WINDOWS_VERSION="node-v10.4.1-win-x86";
  curl "https://nodejs.org/dist/latest/$WINDOWS_VERSION.zip" --output node-install.zip;
  unzip ./node-install.zip -d ~/$WINDOWS_VERSION;
  mv ~/$WINDOWS_VERSION/* ~/.node;
  rm -rf ~/$WINDOWS_VERSION;
  rm -rf ./node-install.zip;

  echo "export PATH=\"$HOME/.node:$PATH\"" >> ~/.${shell}rc;
fi

# Initialize shell configuration
$shell -c "source ~/.${shell}rc";

# Initialize project if it has not already been initialized
if [ ! -f ./package.json ]; then
  npm init -y;
fi

# Install global dependencies
if [ ! $(which parcel) ]; then
  npm install -g parcel-bundler;
fi

if [ ! $(which http-server) ]; then
  npm install -g http-server;
fi

# Install local/dev dependecies
npm install --save-dev eslint;

# Hide some directories from version control/git
echo -e ".cache\ndist\nnode_modules" > .gitignore

# Finish up
echo "Project initialized! Please restart your terminal."
