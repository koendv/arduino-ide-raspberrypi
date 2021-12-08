# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)


This is [arduino-ide 2](https://github.com/arduino/arduino-ide) compiled for raspberry pi os 64-bit.

## Installation

arduino-ide 2.0 is available as appimage.

Home directory on external usb disk recommended; home directory on internal sd card can be painfully slow.

## Installation as AppImage


To install the appimage, download and run [Arduino_IDE-aarch64.AppImage](https://github.com/koendv/arduino-ide-raspberrypi/releases/latest/download/Arduino_IDE-aarch64.AppImage):

```
wget https://github.com/koendv/arduino-ide-raspberrypi/releases/latest/download/Arduino_IDE-aarch64.AppImage
chmod +x Arduino_IDE-aarch64.AppImage
./Arduino_IDE-aarch64.AppImage
```

## STM32duino

A companion board package [stm32 tools](https://github.com/koendv/Arduino_Tools) allows compiling arduino sketches for STM32 Blue Pill on raspberry.

To use, install the following packages on your raspberry pi:
```
sudo apt-get install stlink-tools stlink-gui stm32flash dfu-util
```

Start Arduino IDE 2.0. From the menu choose *File->Preferences*. In *Additional boards manager URLSs*, add the following url:

 ```https://raw.githubusercontent.com/koendv/BoardManagerFiles/master/package_stmicroelectronics_index.json```

This installs the board support package for STM32. In the dropdown box *Select Other Board & Port*. You should now be able to select STM32 boards.

If you like this, maybe you want to buy me a cup of tea:

[![ko-fi](images/kofibutton.svg)](https://ko-fi.com/Q5Q03LPDQ)

## Developers

Compilation notes are in [README-DEVELOPER.md](README-DEVELOPER.md)

not truncated.
