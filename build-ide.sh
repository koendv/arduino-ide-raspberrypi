#!/bin/bash -x
sudo apt-get install libxkbfile-dev libsecret-1-dev
git clone -b 2.0.0-rc6 https://github.com/arduino/arduino-ide
cd arduino-ide
wget https://raw.githubusercontent.com/koendv/arduino-ide-raspberrypi/main/arduino-ide.patch
patch -p1 < arduino-ide.patch
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
