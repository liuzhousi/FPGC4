#!/bin/bash
if [ ! $# -eq 2 ]
  then
    echo "Please give two arguments"
    echo "arg1: device (/dev/ttyACM0)"
    echo "arg2: code (code.asm)"
    exit 
fi

device=$1
code=$2

fileSize=$(stat -c %s code.bin)

python3 spi_flash_programmer_client.py -d $device -l $fileSize -f $code write

python3 spi_flash_programmer_client.py -d $device -f verify.bin -l $fileSize read

difference=$(diff verify.bin $code)

if [ -z "$difference" ]
then
      echo "Flash successful"
else
      echo "Verification failed!"
fi
