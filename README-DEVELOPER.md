# arduino-ide 2.0.0 for Raspberry Pi

## Beta

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)

These are compilation notes for [arduino-ide 2](https://github.com/arduino/arduino-ide) on raspberry pi os 64-bit.

## Compiling the IDE

These are instructions on compiling arduino-ide from source. You can build arduino-ide manually, as a shell script, or from github actions.

## shell script
Execute [build-ide.sh](build-ide.sh) on raspberry pi os *Bullseye* 64-bit.
```
 $ uname -a
Linux raspberrypi 5.10.103-v8+ #1530 SMP PREEMPT Tue Mar 8 13:06:35 GMT 2022 aarch64 GNU/Linux
 $ ./arduino-ide-raspberrypi/build-ide.sh
```
This creates two files in ``arduino-ide/electron/build/dist/``: ``arduino-ide_2.0.0-*_Linux_ARM64.zip `` and ``arduino-ide_2.0.0-*_Linux_ARM64.AppImage ``


## github action
This requires setting up your raspberry pi as a github [self-hosted runner](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)

- in github, fork arduino/arduino-ide
- patch your fork with file self_hosted_runner.patch
- configure a new self-hosted runner:
 In "Settings -> Actions -> Runners -> New Self-hosted Runner", choose:
	- Runner image: Linux
	- Architecture: ARM64
- Follow instructions to create a self-hosted runner, from "Create a folder" to "Last step, run it!".
- In "Actions" choose "Arduino IDE" and click "Run workflow"
- After run, arm64 binaries for raspberry pi are in "Artifacts."

On the runner:
```
$ ./run.sh
√ Connected to GitHub

Current runner version: '2.290.1'
2022-04-25 07:59:29Z: Listening for Jobs
2022-04-25 08:24:16Z: Running job: build
[sudo] password for koen: 
2022-04-25 09:02:18Z: Job build completed with result: Succeeded
```

Build time is 38 minutes on a raspberry pi 4b, 8gb ram, running off a Samsung T5 external SSD disk.

not truncated.
