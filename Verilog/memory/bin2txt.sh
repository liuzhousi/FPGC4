hexdump -v -e '16/1 "%02x " "\n"' rom.bin | tr '\n' ' ' > rom.txt

