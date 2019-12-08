#quick and dirty. will even stop working when size is bigger than 4096
python3 spi_flash_programmer_client.py -d /dev/ttyACM0 -l 4096 -f code.bin write
