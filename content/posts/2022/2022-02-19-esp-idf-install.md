---
title: "ESP-IDF Install"
date: 2022-02-19T17:27:29Z
draft: true
categories:
  - embedded
  - esp32
---

## What is ESP-IDF?

The ESP-IDF is an Internet of Things (IoT) Development Framework provided by Espessif for working with ESP devices. It contains the relevant build tools and scripts to operate the ESP toolchain, build/debug applications and flash them to ESP microcontrollers.

There are many more features provided by the ESP-IDF, refer to the Getting Started guide below.

[ESP-IDF Getting Started](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/index.html#)

## Installing ESP-IDF on Mac OS

### Prerequisites

- [Homebrew](https://docs.brew.sh/Installation)

You can use the below script to install & configure everything in one command:

```bash
#!/usr/bin/env bash

ESP_HOME="$HOME/esp"

# Install dependencies
brew install git python3 cmake ninja dfu-util ccache

# Download the ESP-IDF
[[ -f "$ESP_HOME" ]] || mkdir -p $ESP_HOME

cd $ESP_HOME
git clone --recursive https://github.com/espressif/esp-idf.git

# Install build tools
cd $ESP_HOME/esp-idf
./install.sh esp32

# Set up shell with IDF environment variables
. ./export.sh
```

It is important to note that each time you wish to use ESP-IDF in a new terminal session, you need to run the `export.sh` script to activate the ESP-IDF environment.

You can use the following shell alias to make this easier:

```bash
echo "alias get_idf='. $HOME/esp/esp-idf/export.sh'" >> ~/.zshrc
```

Then when you wish to work on a project, simply run the `get_idf` command to set up the necessary environment variables.

## Testing the ESP-IDF with a sample project

To test our new ESP-IDF installation, lets create a new project from one of the examples provided by ESP-IDF.

First, ensure the ESP device is connected to the computer via USB.

In order to build & flash the project, we need to determine the port used by our ESP device. Generally, ESP devices will occupy a port such as `/dev/cu.*`

```bash
ls -lA /dev/cu.*
```

```plain
crw-rw-rw-  1 root  wheel  0x16000001 19 Feb 17:54 /dev/cu.BLTH
crw-rw-rw-  1 root  wheel  0x16000007 13 Feb 15:31 /dev/cu.Bluetooth-Incoming-Port
crw-rw-rw-  1 root  wheel  0x16000005 13 Feb 15:31 /dev/cu.URT1
crw-rw-rw-  1 root  wheel  0x16000003 13 Feb 15:31 /dev/cu.URT2
crw-rw-rw-  1 root  wheel  0x1600000b 19 Feb 17:54 /dev/cu.usbmodem51850090371
crw-rw-rw-  1 root  wheel  0x16000009 19 Feb 17:54 /dev/cu.wchusbserial51850090371
```

In this case, the ESP device is using `/dev/cu.wchusbserial51850090371`. For ease, we can set an environment variable for this value.

```bash
export ESP_PORT=/dev/cu.wchusbserial51850090371
```

Now we can create a new project, build, flash, and monitor our application.

```bash
mkdir -p ~/projects/esp-test
cd ~/projects/esp-test
get_idf
cp -r ~/esp/esp-idf/examples/get-started/hello-world .
cd hello-world
idf.py -p $ESP_PORT flash monitor
```

> Note: the first build will take a while. Subsequent builds will be much faster.

If all was successful, we will see the `Hello world!` message in the Serial Monitor.

![hello-world](/img/2022/2022-02-19-esp-idf-install/hello-world.png)

To exit the Serial Monitor, press `Ctrl+]`.

For a full list of `idf.py` commands, use the `idf.py -h` command or refer to the [documentation](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/build-system.html#idf-py).
