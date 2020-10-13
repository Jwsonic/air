#!/usr/bin/env bash

if [ ! -f .env ]; then
    echo "You must provide an ENV file"
fi

source .env

required_vars=("MIX_TARGET" "NERVES_NETWORK_SSID" "NERVES_NETWORK_PSK" "NERVES_DEVICE_NAME" "SECRET_KEY_BASE")

for var in "${required_vars[@]}" 
do
  [ ! -v $var ] && echo "You must set $var." && exit 1;
done

echo "Building $NERVES_DEVICE_NAME!"

if [ -n "$BUILD_SENSORS" ]; then
  echo "Including sensors"
fi

if [ -n "$BUILD_DISPLAY" ]; then
  echo "Including display"
fi

(
  cd firmware || exit
  mix deps.update --all
  mix deps.get
  mix deps.compile
  mix firmware
)