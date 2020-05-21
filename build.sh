#!/bin/sh
set -e

#--------------------------------------------------------------------------------------------------
# Settings
#--------------------------------------------------------------------------------------------------

external="$PWD/../3rdparty"

#--------------------------------------------------------------------------------------------------

Qt5_version="5.14.2"

#--------------------------------------------------------------------------------------------------

make_arguments="-j 4"

#--------------------------------------------------------------------------------------------------
# Windows

ProgramFiles="/c/Program Files (x86)"

BuildTools="$ProgramFiles/Microsoft Visual Studio/2019/BuildTools"

#--------------------------------------------------------------------------------------------------

MinGW_version="7.3.0"

jom_version="1.1.3"

MSVC_version="14"

WindowsKit_version="10"

#--------------------------------------------------------------------------------------------------
# Android

NDK_version="21"

#--------------------------------------------------------------------------------------------------
# Functions
#--------------------------------------------------------------------------------------------------

getOs()
{
    os=`uname`

    case $os in
    MINGW*)  os="windows";;
    Darwin*) os="macOS";;
    Linux*)  os="linux";;
    *)       os="other";;
    esac

    type=`uname -m`

    if [ $type = "x86_64" ]; then

        if [ $os = "windows" ]; then

            echo win64
        else
            echo $os
        fi

    elif [ $os = "windows" ]; then

        echo win32
    else
        echo $os
    fi
}

getPath()
{
    echo $(ls "$1" | grep $2 | tail -1)
}

#--------------------------------------------------------------------------------------------------
# Syntax
#--------------------------------------------------------------------------------------------------

if [ $# != 1 -a $# != 2 ] \
   || \
   [ $1 != "win32" -a $1 != "win64" -a $1 != "win32-msvc" -a $1 != "win64-msvc" -a \
     $1 != "macOS" -a $1 != "linux" ] \
   || \
   [ $# = 2 -a "$2" != "deploy" -a "$2" != "clean" ]; then

    echo "Usage: build <win32 | win64 | win32-msvc | win64-msvc | macOS | linux>"
    echo "             [deploy | clean]"

    exit 1
fi

#--------------------------------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------------------------------

host=$(getOs)

external="$external/$1"

if [ $1 = "win32" -o $1 = "win64" -o $1 = "win32-msvc" -o $1 = "win64-msvc" ]; then

    os="windows"

    if [ $1 = "win32" -o $1 = "win64" ]; then

        compiler="mingw"

        MinGW="$external/MinGW/$MinGW_version/bin"
    else
        compiler="msvc"

        jom="$external/jom/$jom_version"

        MSVC_version=$(getPath "$BuildTools/VC/Tools/MSVC" $MSVC_version)

        MSVC="$BuildTools/VC/Tools/MSVC/$MSVC_version"

        WindowsKit="$ProgramFiles/Windows Kits/$WindowsKit_version"

        WindowsKit_version=$(getPath "$WindowsKit/bin" $WindowsKit_version)

        echo "MSVC version $MSVC_version"
        echo ""
        echo "WindowsKit version $WindowsKit_version"
        echo ""

        if [ $1 = "win32-msvc" ]; then

            target="x86"
        else
            target="x64"
        fi
    fi
else
    os="default"

    compiler="default"
fi

Qt="$external/Qt/$Qt5_version"

if [ $os = "windows" -o $1 = "macOS" ]; then

    qmake="$Qt/bin/qmake"
else
    qmake="qmake"
fi

#--------------------------------------------------------------------------------------------------
# Clean
#--------------------------------------------------------------------------------------------------

if [ "$2" = "clean" ]; then

    echo "CLEANING"

    # NOTE: We have to remove the folder to delete .qmake.stash.
    rm -rf build
    mkdir  build
    touch  build/.gitignore

    exit 0
fi

#--------------------------------------------------------------------------------------------------
# Build ALVR2
#--------------------------------------------------------------------------------------------------

echo "BUILDING ALVR2"
echo "--------------"

export QT_SELECT=qt5

config="CONFIG+=release"

if [ $compiler = "mingw" ]; then

    spec=win32-g++

    PATH="$Qt/bin:$MinGW:$PATH"

elif [ $compiler = "msvc" ]; then

    spec=win32-msvc

    PATH="$jom:$MSVC/bin/Host$target/$target:\
$WindowsKit/bin/$WindowsKit_version/$target:\
$Qt/bin:$PATH"

export INCLUDE="$MSVC/include:\
$WindowsKit/Include/$WindowsKit_version/ucrt:\
$WindowsKit/Include/$WindowsKit_version/um:\
$WindowsKit/Include/$WindowsKit_version/shared"

export LIB="$MSVC/lib/$target:\
$WindowsKit/Lib/$WindowsKit_version/ucrt/$target:\
$WindowsKit/Lib/$WindowsKit_version/um/$target"

elif [ $1 = "macOS" ]; then

    spec=macx-clang

    export PATH=$Qt/bin:$PATH

elif [ $1 = "linux" ]; then

    if [ -d "/usr/lib/x86_64-linux-gnu" ]; then

        spec=linux-g++-64
    else
        spec=linux-g++-32
    fi
fi

$qmake --version
echo ""

cd build

$qmake -r -spec $spec "$config" ..

if [ $compiler = "mingw" ]; then

    mingw32-make $make_arguments

elif [ $compiler = "msvc" ]; then

    jom
else
    make $make_arguments
fi

cd ..

echo "--------------"

#--------------------------------------------------------------------------------------------------
# Deploying ALVR2
#--------------------------------------------------------------------------------------------------

if [ "$2" = "deploy" ]; then

    echo ""
    echo "DEPLOYING ALVR2"
    echo "---------------"

    sh deploy.sh $1

    echo "---------------"
fi