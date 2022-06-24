# arduino-ide 2.0.0 for Raspberry Pi

[![arduino ide 2.0](images/screenshot_small.jpg)](https://github.com/koendv/arduino-ide-raspberrypi/raw/main/images/screenshot.jpg)

## compiling the IDE

These are instructions on compiling for [arduino-ide 2](https://github.com/arduino/arduino-ide) from source on raspberry pi os 64-bit. Compiling is done using github actions, the same build process as on X86.

Compilation using github actions requires

- setting up your raspberry pi as a github [self-hosted runner](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
- patching arduino-ide to add arm64 processors to the build process.

## set up raspberry pi

On the raspberry pi runner:

- Install Raspberry Pi OS 64-bit.
- install [docker](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script).

## patch arduino-ide

Set up a copy of the arduino-ide github.

- in github, fork [arduino/arduino-ide](https://github.com/arduino/arduino-ide)
- patch your fork with file self_hosted_runner.patch
```
git clone https://github.com/koendv/arduino-ide-raspberrypi
git clone https://github.com/your_git_account/arduino-ide
cd arduino-ide
patch -p1 < ../arduino-ide-raspberrypi/self_hosted_runner.patch
git add .github/workflows/build.yml
git add arduino-ide-extension/scripts/download-ls.js
git commit -m arm64
git push
```

The patch `self_hosted_runner.patch` adds a new build target "self-hosted", next to Windows, Ubuntu and MacOS.

## configure self-hosted runner
Configure a new self-hosted runner.
On github.com, go to your fork of the arduino-ide.

- In _Settings -> Moderation options -> Code review limits_, enable  "Limit to users explicitly granted read or higher access"
- In _Settings -> General -> Code and Automation -> Actions -> Runners_, click on _New Self-Hosted Runner_.

## set up docker

For repeatability and convenience, the self-hosted runner runs in a docker image.

On the raspberry, type:

```
git clone https://github.com/myoung34/docker-github-actions-runner
cd docker-github-actions-runner
patch -p1 < ../arduino-ide-raspberrypi/docker-github-actions-runner.patch
```

The patch `docker-github-actions-runner.patch` adds build dependencies - npm, yarn, and libraries - to the docker image.

Next, copy the shell script to run docker:
```
cp ../arduino-ide-raspberrypi/docker-github-actions-runner.sh .
```
Edit `docker-github-actions-runner.sh`. 

- DOCKER_DIR is the directory with the Dockerfile
- REPO_URL points to your fork of the arduino-ide
- ACCESS_TOKEN is your github access token.

Start the self-hosted runner:
```
./docker-github-actions-runner.sh
```

Output should end with `Listening for Jobs`

## start the build

On github.com, go to your fork of the arduino-ide.

- In "Actions", under "Workflows" choose "Arduino IDE", enable workflow.
- Click "Run workflow"
- On the runner, output should be ``Running job: build (self-hosted)``. You can follow what happens in the build through the github web interface.

Build time is less than one hour on a raspberry pi 4b, 8gb ram.
```
√ Connected to GitHub

Current runner version: '2.294.0'
2022-06-23 13:07:35Z: Listening for Jobs
2022-06-23 13:09:38Z: Running job: build (self-hosted)
2022-06-23 13:54:14Z: Job build (self-hosted) completed with result: Succeeded

```

## download binaries

- After the run, arm64 binaries for raspberry pi are on github, in "Artifacts."
- On github.com, go to your fork of the arduino-ide. Under "All workflows - Showing runs from all workflows" click on "Arduino IDE". The binaries are under "Artifacts - Produced during runtime
":
``Linux_ARM64_app_image`` and
``Linux_ARM64_zip``. Click to download.
- When the build is completed and the binaries downloaded, stop the runner and delete your arduino-ide fork. It is no longer needed.

not truncated.
