# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)

These are compilation notes for [arduino-ide 2](https://github.com/arduino/arduino-ide) on raspberry pi os 64-bit.

## Compiling the IDE

These are instructions on compiling arduino-ide from source.

To compile the arduino ide on raspberry pi os:

## install debian packages

add backports to apt sources, needed for go 1.14.

```
echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list
apt-key adv --keyserver   keyserver.ubuntu.com --recv-keys 7638D0442B90D010
apt-key adv --keyserver   keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC

apt-get update -q --fix-missing
apt-get install -y -q software-properties-common
apt-get install -y -q --no-install-recommends build-essential libssl-dev golang-1.14-go golang-1.14-go libxkbfile-dev libnss3-dev
apt-get install autoconf automake libtool curl make cmake ninja-build g++ unzip
 export PATH=/usr/lib/go-1.14/bin:$PATH
```

## clangd

Download clangd binary from [releases](https://github.com/koendv/arduino-ide-raspberrypi/releases/), or compile clangd from sources:

```
git clone -b llvmorg-12.0.0 https://github.com/llvm/llvm-project
cd llvm-project
export LLVM_ROOT=$PWD
mkdir build
cd build
cmake $LLVM_ROOT/llvm/ -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DLLVM_STATIC_LINK_CXX_STDLIB=ON -DLLVM_BUILD_STATIC=ON -G Ninja
cmake --build $LLVM_ROOT/build --target clangd
zip -r clangd-12.0.0_Linux_ARM64.zip ./bin/clangd ./lib/clang/
```
Copy clangd-12.0.0_Linux_ARM64.zip, will be needed later.

## arduino language server

Download arduino-language-server binary from [releases](https://github.com/koendv/arduino-ide-raspberrypi/releases/), or compile arduino-language-server from sources:

```
export PATH=/usr/lib/go-1.14/bin:$PATH
git clone https://github.com/arduino/arduino-language-server
cd arduino-language-server
go version
# check go version 1.14
go build
zip arduino-language-server_Linux_ARM64.zip ./arduino-language-server
```
Copy arduino-language-server_Linux_ARM64.zip, will be needed later.

## arduino-cli

``arduino-cli`` binaries for Linux_ARMv6, Linux_ARMv7, Linux_ARM64 are available from [arduino-cli git](https://github.com/arduino/arduino-cli). The binaries are downloaded by the build script.

## arduino-ide

Build the IDE. Download arduino-ide sources from git:

```
git clone https://github.com/arduino/arduino-ide
cd arduino-ide
export ARD_DIR=$PWD
cd $ARD_DIR/arduino-ide-extension/
mkdir build
```
unzip your clangd and arduino-language-server binaries in the directory ``arduino-ide-extension/build``, or download and unzip pre-built clangd and arduino-language-server binaries:

```
cd $ARD_DIR/arduino-ide-extension/build
wget https://github.com/koendv/arduino-ide-raspberrypi/releases/download/2.0.0-beta.5-snapshot.0dd1e45/arduino-language-server_Linux_ARM64.zip
unzip arduino-language-server_Linux_ARM64.zip
rm -f arduino-language-server_Linux_ARM64.zip

wget https://github.com/koendv/arduino-ide-raspberrypi/releases/download/2.0.0-beta.5-snapshot.0dd1e45/clangd-12.0.0_Linux_ARM64.zip
unzip clangd-12.0.0_Linux_ARM64.zip
rm -f clangd-12.0.0_Linux_ARM64.zip
```
 

Continue the build:
```
cd $ARD_DIR
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
 . ~/.config/nvm/nvm.sh
 . ~/.config/nvm/bash_completion
nvm install 12.14.1
npm install --global yarn
npm install "@octokit/core@>=3"
npm install "react@16.14.0" "react-dom@16.14.0"
npm install "less@^2.3.1"
npm install "font-awesome@>=4.3.0"
npm install request

# needs /usr/lib/arm-linux-gnueabihf/pkgconfig/xkbfile.pc
export PKG_CONFIG_PATH=/usr/lib/arm-linux-gnueabihf/pkgconfig/
yarn
yarn rebuild:electron
```
At this point, you can test run arduino-ide with: ```yarn start```

Continue with packaging:

```
yarn --cwd ./electron/packager/
yarn --cwd ./electron/packager/ package

```

This creates the file ``$ARD_DIR/electron/build/dist/arduino-ide_2.0.0-beta.5-snapshot.0dd1e45_Linux_ARM64.zip``

## appimage

To make deployment easier, create an appimage.
Download latest AppRun and appimagetool from [git](https://github.com/AppImage/AppImageKit/releases/tag/continuous)

```
mkdir -p arduino-ide-appdir/usr/bin arduino-ide-appdir/usr/lib
cd arduino-ide-appdir
export APP_ROOT=$PWD
cd $APP_ROOT/usr/bin
unzip unzip ~/src/binaries/arduino-ide_2.0.0-beta.5-snapshot.0dd1e45_Linux_ARM64.zip
cp *.so $APP_ROOT/usr/lib/
cd $APP_ROOT
cat >arduino-ide.desktop <<EOD
[Desktop Entry]
Type=Application
Version=1.0
Name=Arduino IDE
Icon=arduino-ide
Exec=arduino-ide %f
MimeType=text/x-arduino;
Categories=Development;Engineering;Electronics;
Keywords=embedded electronics;electronics;microcontroller;
X-AppImage-Version=2.0.0-beta5
EOD
wget -O arduino-ide.svg http://halley.cc/paste/arduino.svg 
wget -O AppRun https://github.com/AppImage/AppImageKit/releases/download/continuous/AppRun-aarch64
chmod +x ./AppRun
```

At this point, you can test run the arduino-ide with: ```./AppRun```

Create the appimage. For aarch64, type:
```  
cd  $APP_ROOT/..
wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-aarch64.AppImage
chmod +x ./appimagetool-aarch64.AppImage
ARCH=arm_aarch64 ~/Downloads/appimagetool-aarch64.AppImage ./arduino-ide-appdir
```
This creates the file ``Arduino_IDE-aarch64.AppImage``.

not truncated.
