# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)


This is [arduino-ide 2](https://github.com/arduino/arduino-ide) compiled for raspberry pi os 64-bit.

## Installation

arduino-ide 2.0 is available both as appimage and as zip file.

Home directory on external usb disk recommended; home directory on internal sd card can be painfully slow.

## Installation as AppImage


To install the appimage, download and run [Arduino_IDE-aarch64.AppImage](https://github.com/koendv/arduino-ide-raspberrypi/releases/latest/download/Arduino_IDE-aarch64.AppImage):

```
wget https://github.com/koendv/arduino-ide-raspberrypi/releases/latest/download/Arduino_IDE-aarch64.AppImage
chmod +x Arduino_IDE-aarch64.AppImage
./Arduino_IDE-aarch64.AppImage
```

## Installation from zip file

To install from zip file, download `arduino-ide_2.*_Linux_ARM64.zip` from [releases](https://github.com/koendv/arduino-ide-raspberrypi/releases/latest) and unzip in a directory, eg.:

To install:

```
mkdir ~/opt/arduino-ide
cd ~/opt/arduino-ide
unzip ~/Downloads/arduino-ide_2.0.0-*_Linux_ARM64.zip
```
This unzips 3.400 directories with 18.000 files.
To run:

```
~/opt/arduino-ide/arduino-ide
```

## STM32duino

A companion board package [stm32 tools](https://github.com/koendv/Arduino_Tools) allows compiling for STM32 Blue Pill on raspberry.


If you like this, maybe you want to buy me a cup of tea:

[![ko-fi](images/kofibutton.svg)](https://ko-fi.com/Q5Q03LPDQ)

## Developers

Compilation notes are in [README-DEVELOPER.md](README-DEVELOPER.md)

not truncated.
