# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)

These are compilation notes for [arduino-ide 2](https://github.com/arduino/arduino-ide) on raspberry pi os 64-bit.

## Compiling the IDE

These are instructions on compiling arduino-ide from source.
Download pre-built clangd and arduino-language-server binaries from _releases_.

Then execute [build-ide.sh](build-ide.sh). Make sure ZIP_DIR points to the directory where you have downloaded the pre-built clangd and arduino-language-server binaries.

This creates two files in ``$ARD_DIR/arduino-ide/electron/build/dist/``: ``arduino-ide_2.0.0-*_Linux_ARM64.zip `` and ``arduino-ide_2.0.0-*_Linux_ARM64.AppImage ``

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
git clone https://github.com/arduino/arduino-language-server
cd arduino-language-server
go version
# check go version 1.16 or higher
go build
zip arduino-language-server_Linux_ARM64.zip ./arduino-language-server
```

not truncated.