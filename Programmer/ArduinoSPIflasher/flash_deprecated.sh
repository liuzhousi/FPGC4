#!/bin/bash

# Flash SPI flash using Arduino (deprecated, you can now use the FPGC4 itself)

if [ ! $# -eq 2 ]
  then
    echo "Please give two arguments"
    echo "arg1: device (/dev/ttyUSB0, or on WSL1: /dev/ttyS{COM port number})"
    echo "arg2: code (code.bin)"
    exit 
fi

device=$1
code=$2

fileSize=$(stat -c %s $code)

python3 spi_flash_programmer_client.py -d $device -l $fileSize -f $code write

python3 spi_flash_programmer_client.py -d $device -f verify.bin -l $fileSize read

difference=$(diff verify.bin $code)

if [ -z "$difference" ]
then
      echo "Flash successful"
else
      echo "Verification failed!"
fi

