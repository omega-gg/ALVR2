#!/bin/sh
set -e

includeGenerator="../../Sky/deploy/includeGenerator"

"$includeGenerator" ../../src/HEVR/src        HEVR
"$includeGenerator" ../../src/libHEVR/src     libHEVR
"$includeGenerator" ../../src/HEVR-OpenVR/src HEVR-OpenVR
