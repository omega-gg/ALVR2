ALVR2
---
[![azure](https://dev.azure.com/bunjee/ALVR2/_apis/build/status/omega-gg.ALVR2)](https://dev.azure.com/bunjee/ALVR2/_build)
[![LGPLv3](https://img.shields.io/badge/License-LGPLv3-blue.svg)](https://www.gnu.org/licenses/lgpl.html)

** This is a work in progress and not yet released **

ALVR2 is a Virtual Reality streaming application.<br>
Designed to play VR games from a standalone headset.<br>
With a focus on low-latency, compatibily and simplicity.<br>

This project is based on the original ALVR project from [polygraphene](https://github.com/polygraphene)
and the ALVR fork from [JackD83](https://github.com/JackD83) and [zarik5](https://github.com/zarik5).

Note: This is the streaming application, you'll need an ALVR client on your headset.

References:
- [ALVR polygraphene](https://github.com/polygraphene/ALVR)
- [ALVR fork JackD83](https://github.com/polygraphene/ALVR)
- [ALVRClient fork JackD83](https://github.com/JackD83/ALVRClient)
- [3unjee devlog](https://github.com/3unjee/devlogs/blob/master/ALVR2.md)

## Community

- [Discord channel](https://discord.gg/ypagkhV)
- [Reddit ALVR](https://www.reddit.com/r/ALVR)

## Technology

ALVR2 is built in C++ with the [Qt framework](https://github.com/qtproject) and [Sky kit](http://omega.gg/Sky/sources).

## Platforms

- Windows 7 and later
- Linux 32 bit and 64 bit
- macOS 64 bit (experimental)

## Hardware compatibily

Headset:
- Oculus Quest

GPU:
- Nvidia GTX 600+, RTX 2000+
- Radeon RX 400+, RX 500+

Network:
- Wireless connection with 5ghz / 802.11ac compatibily

## Requirements

On Windows:
- [Git for Windows](https://git-for-windows.github.io)

Recommended IDE:
- [Qt Creator](https://download.qt.io/official_releases/qtcreator)

## Quickstart

You can configure and build ALVR2 with a single line:

    sh build.sh <win32 | win64 | win32-msvc | win64-msvc | macOS | linux> all

For instance you would do that on Windows:

    * open Git Bash *
    git clone https://github.com/omega-gg/ALVR2.git
    cd ALVR2
    sh build.sh win32 all

That's a convenient way to set everything up the first time.

Note: This will create the 3rdparty and Sky folder in the parent directory.

## Building

After that, you can run each step of the build yourself by calling the following scripts:

Install the dependencies:

    sh 3rdparty.sh <win32 | win64 | win32-msvc | win64-msvc | macOS | linux>

Configure the build:

    sh configure.sh <win32 | win64 | win32-msvc | win64-msvc | macOS | linux>
                    [sky | clean]

Build the application:

    sh build.sh <win32 | win64 | win32-msvc | win64-msvc | macOS | linux>
                [all | deploy | clean]

Deploy the application and its dependencies:

    sh deploy.sh <win32 | win64 | win32-msvc | win64-msvc | macOS | linux>
                 [clean]

## License

Copyright (C) 2015 - 2020 ALVR2 authors | http://omega.gg/ALVR2

### Authors

- Benjamin Arnaud aka [bunjee](http://bunjee.me) | <bunjee@omega.gg>

### GNU Lesser General Public License Usage

ALVR2 may be used under the terms of the GNU Lesser General Public License version 3 as published
by the Free Software Foundation and appearing in the LICENSE.md file included in the packaging of
this file. Please review the following information to ensure the GNU Lesser General Public License
requirements will be met: https://www.gnu.org/licenses/lgpl.html.
