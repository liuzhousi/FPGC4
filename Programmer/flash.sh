#quick and dirty. will even stop working when size is bigger than 4096
python3 spi_flash_programmer_client.py -d /dev/ttyACM0 -l 8192 -f code.bin write

# do read with python3 spi_flash_programmer_client.py -d /dev/ttyACM0 -f test.bin -l 8192 read
# compare with diff test.bin code.bin