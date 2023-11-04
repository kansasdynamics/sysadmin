#!/bin/bash

## Install NVM, NPM, and Node.js on an Ubuntu server
sudo apt-get update -y
sudo apt-get install nodejs npm -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
command -v nvm
nvm install 14.17.6
npm install npm@6.14.15
npm install
