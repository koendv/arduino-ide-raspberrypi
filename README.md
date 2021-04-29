# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)


This is [arduino-ide 2](https://github.com/arduino/arduino-ide) compiled for raspberry pi os 64-bit.

## Installation

Installation is downloading [arduino-ide_2.*_Linux_ARM64.zip](https://github.com/koendv/arduino-ide-raspberrypi/releases/download/2.0.0-beta.5-snapshot.0dd1e45/arduino-ide_2.0.0-beta.5-snapshot.0dd1e45_Linux_ARM64.zip) and unzipping in a directory, eg.:

To install:

```
mkdir ~/opt/arduino-ide
cd ~/opt/arduino-ide
unzip ~/Downloads/arduino-ide_2.0.0-beta.5-snapshot.0dd1e45_Linux_ARM64.zip
```

To run:

```
~/opt/arduino-ide/arduino-ide
```

A companion board package [stm32 tools](https://github.com/koendv/Arduino_Tools) allows compiling for STM32 Blue Pill.

## AppImages
arduino-ide is also available as appimage.
To install the appimage, download [Arduino_IDE-aarch64.AppImage](https://github.com/koendv/arduino-ide-raspberrypi/releases/download/2.0.0-beta.5-snapshot.0dd1e45/Arduino_IDE-aarch64.AppImage) from releases and type:

```
chmod +x Arduino_IDE-aarch64.AppImage
./Arduino_IDE-aarch64.AppImage
```

If you like this, maybe you want to buy me a cup of tea:

[![ko-fi](images/kofibutton.svg)](https://ko-fi.com/Q5Q03LPDQ)

## Developers

Compilation notes are in ``README-DEVELOPER.md``

not truncated.
