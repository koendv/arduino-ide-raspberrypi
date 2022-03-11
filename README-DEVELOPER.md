# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)

These are compilation notes for [arduino-ide 2](https://github.com/arduino/arduino-ide) on raspberry pi os 64-bit.

## Compiling the IDE

These are instructions on compiling arduino-ide from source.
Execute [build-ide.sh](build-ide.sh) on raspberry pi os *Bullseye* 64-bit.
```
 $ uname -a
Linux raspberrypi 5.10.103-v8+ #1530 SMP PREEMPT Tue Mar 8 13:06:35 GMT 2022 aarch64 GNU/Linux
 $ ./arduino-ide-raspberrypi/build-ide.sh
```
This creates two files in ``arduino-ide/electron/build/dist/``: ``arduino-ide_2.0.0-*_Linux_ARM64.zip `` and ``arduino-ide_2.0.0-*_Linux_ARM64.AppImage ``

not truncated.
