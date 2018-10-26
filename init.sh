#!/bin/sh

shell=bash

# Detect shell variant
if [ -f ~/.zshrc ]; then
  shell=zsh
elif [ ! -f ~/.bashrc ]; then
  # add .bashrc if needed
  touch ~/.bashrc
fi

if [ ! $(cat ~/.bash_profile | grep bashrc) ]; then
  echo "[[ -r ~/.bashrc ]] && . ~/.bashrc;" >>~/.bash_profile
fi

# Install latest node and npm versions
if [ $(which python) ]; then
  # Install NVM (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | $shell

  # Initialize NVM
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

  nvm install node
elif [ ! $(which node) ]; then
  echo "please install Node.js through the Windows Installer!"
  exit
fi

# Initialize shell configuration
$shell -c "source ~/.${shell}rc"

# Initialize project if it has not already been initialized
if [ ! -f ./package.json ]; then
  npm init -y
fi

# Install global dependencies
npm install -g http-server

# Install local/dev dependecies
npm install --save-dev parcel-bundler eslint

# Hide some directories from version control/git
echo -e ".DS_Store\n.cache\ndist\nnode_modules\n*.sw*" >.gitignore

# Copy over the .eslintrc file
curl -o- https://raw.githubusercontent.com/NAlexPear/savvy-course-materials/master/.eslintrc >.eslintrc

# Create a _redirects file for Netlify
echo -e "/* /index.html 200" >_redirects

# Finish up
echo "Project initialized! Please restart your terminal."
