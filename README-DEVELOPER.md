# arduino-ide 2.0.0 for Raspberry Pi

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.png)

## compiling the IDE

These are instructions on compiling for [arduino-ide 2](https://github.com/arduino/arduino-ide) from source on raspberry pi os 64-bit. Compiling is done using github actions, the same build process as on X86. 

Compilation using github actions requires

- setting up your raspberry pi as a github [self-hosted runner](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
- patching arduino-ide to add arm64 processors to the build process.

## set up raspberry pi 

On the raspberry pi runner:

- Install Raspberry Pi OS 64-bit.
- install dependencies: node, yarn, and libraries.

```
sudo apt-get install libxkbfile-dev libsecret-1-dev
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
. ~/.config/nvm/nvm.sh
. ~/.config/nvm/bash_completion
nvm install 14.0.0
npm install --global yarn
```

- make sure python is python 3.

## patch arduino-ide

Set up a copy of the arduino-ide github.

- in github, fork arduino/arduino-ide
- patch your fork with file self_hosted_runner.patch
```
git clone https://github.com/koendv/arduino-ide-raspberrypi
git clone https://github.com/koendv/arduino-ide
cd arduino-ide
patch -p1 < ../arduino-ide-raspberrypi/self_hosted_runner.patch
git add .github/workflows/build.yml
git add arduino-ide-extension/scripts/download-ls.js
git commit -m arm64
git push
```

In .github/workflows/build.yml, this adds a new os "self-hosted", next to Windows, Ubuntu and MacOS.

## configure self-hosted runner

- configure a new self-hosted runner.
On github.com, go to your fork of the arduino-ide.
 In "Settings -> Actions -> Runners -> New Self-hosted Runner", choose:
	- Runner image: Linux
	- Architecture: ARM64
- Follow instructions to create a self-hosted runner, from "Create a folder" to "Last step, run it!". On the raspberry pi, type:
```
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-arm64-2.290.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.290.1/actions-runner-linux-arm64-2.290.1.tar.gz
tar xzf ./actions-runner-linux-arm64-2.290.1.tar.gz
./config.sh --url https://github.com/koendv/arduino-ide --token SECRET_TOKEN
```

Verify node and yarn are available, then start the runner:

```
node --version
yarn --version
./run.sh
```
This should output _Listening for Jobs_.

## build ide

On github.com, go to your fork of the arduino-ide.

- In "Actions", under "Workflows" choose "Arduino IDE", enable workflow and click "Run workflow"
- On the runner, output should be ``Running job: build (self-hosted)``. You can follow what happens in the build through the github web interface.

Build time is 35-45 minutes on a raspberry pi 4b, 8gb ram. 
```
 $ ./run.sh 
√ Connected to GitHub
Current runner version: '2.290.1'
2022-04-29 06:52:32Z: Listening for Jobs
2022-04-29 06:56:32Z: Running job: build (self-hosted)
2022-04-29 07:37:11Z: Job build (self-hosted) completed with result: Succeeded
```

## binaries

- After the run, arm64 binaries for raspberry pi are in "Artifacts." 
- On github.com, go to your fork of the arduino-ide. Under "All workflows - Showing runs from all workflows" click on "Arduino IDE". The binaries are under "Artifacts - Produced during runtime
": 
``Linux_ARM64_app_image`` and 
``Linux_ARM64_zip``. Click to download.

not truncated.