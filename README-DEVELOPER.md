# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)

These are compilation notes for [arduino-ide 2](https://github.com/arduino/arduino-ide) on raspberry pi os 64-bit.

## Compiling the IDE

These are instructions on compiling arduino-ide from source.
Download pre-built clangd and arduino-language-server binaries from _releases_.

Then execute [build-ide.sh](build-ide.sh). Make sure ZIP_DIR points to the directory where you have downloaded the pre-built clangd and arduino-language-server binaries.

This creates the file ``$ARD_DIR/arduino-ide/electron/build/dist/arduino-ide_2.0.0-rc1-snapshot.767b09d_Linux_ARM64.zip ``

## appimage

To make deployment easier, create an appimage.
Download latest AppRun and appimagetool from [git](https://github.com/AppImage/AppImageKit/releases/tag/continuous)

```
mkdir -p arduino-ide-appdir/usr/bin arduino-ide-appdir/usr/lib
cd arduino-ide-appdir
export APP_ROOT=$PWD
cd $APP_ROOT/usr/bin
unzip $ARD_DIR/arduino-ide/electron/build/dist/arduino-ide_2.0.0-rc2-snapshot.0b6fc0b_Linux_ARM64.zip
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
X-AppImage-Version=2.0.0-rc2
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
ARCH=arm_aarch64 ./appimagetool-aarch64.AppImage ./arduino-ide-appdir
```
This creates the file ``Arduino_IDE-aarch64.AppImage``.

## clangd

The clangd binary from [releases](https://github.com/koendv/arduino-ide-raspberrypi/releases/) has been compiled like this:

```
git clone -b llvmorg-13.0.0 https://github.com/llvm/llvm-project
cd llvm-project
export LLVM_ROOT=$PWD
mkdir build
cd build
cmake $LLVM_ROOT/llvm/ -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DLLVM_STATIC_LINK_CXX_STDLIB=ON -DLLVM_BUILD_STATIC=ON -G Ninja
cmake --build $LLVM_ROOT/build --target clangd
zip -r clangd-13.0.0_Linux_ARM64.zip ./bin/clangd ./lib/clang/
```

## arduino language server

The arduino-language-server binary from [releases](https://github.com/koendv/arduino-ide-raspberrypi/releases/) has been compiled like this:

You need go 1.16 or higher. [Download](https://go.dev/dl/) and install if needed.

```
export PATH=/usr/lib/go-1.14/bin:$PATH
git clone -b 2.0.0-beta.6 https://github.com/arduino/arduino-language-server
cd arduino-language-server
go version
# check go version 1.16 or higher
go build
zip arduino-language-server_Linux_ARM64.zip ./arduino-language-server
```

not truncated.
