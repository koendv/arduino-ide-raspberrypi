#!/bin/bash
export ZIP_DIR=~/src/arduino-ide-builds
sudo apt-get install libxkbfile-dev libsecret-1-dev
git clone https://github.com/arduino/arduino-ide
cd arduino-ide
patch -p1 < ../arduino-ide-raspberrypi/arduino-ide.patch
export ARD_DIR=$PWD
cd $ARD_DIR/arduino-ide-extension/
mkdir build
cd build
unzip $ZIP_DIR/clangd-13.0.0_Linux_ARM64.zip
unzip $ZIP_DIR/arduino-language-server_Linux_ARM64.zip
cd $ARD_DIR
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
. ~/.config/nvm/nvm.sh
. ~/.config/nvm/bash_completion
nvm install 14.0.0
npm install --global yarn
yarn install
yarn
(cd electron-app; yarn theia rebuild:electron )
yarn --cwd ./electron/packager/
yarn --cwd ./electron/packager/ package
#not truncated
