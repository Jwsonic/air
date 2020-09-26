#!/usr/bin/env bash

source build.sh

(
  cd firmware || exit
  mix firmware.burn
)