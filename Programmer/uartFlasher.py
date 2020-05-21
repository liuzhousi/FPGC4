import serial
from time import sleep

port = serial.Serial("/dev/ttyUSB0", baudrate=115200, timeout=None)

sleep(0.1) # give the FPGC time to reset

# parse byte file
ba = bytearray()

with open("code.bin", "rb") as f:
    bytes_read = f.read()
for b in bytes_read:
    ba.append(b)

# combine each 4 bytes into a word
n = 4
wordList = [ba[i * n:(i + 1) * n] for i in range((len(ba) + n - 1) // n )]  

# size of program is in address 5
fileSize = bytes(wordList[5])

print(int.from_bytes(fileSize, "big"), flush=True)

# write filesize
port.write(fileSize)

# read four bytes
rcv = port.read(4)

# to verify if communication works
print(rcv, flush=True)


# send all words
doneSending = False

wordCounter = 0

while not doneSending:
    port.write(bytes(wordList[wordCounter]))
    wordCounter = wordCounter + 1

    if (wordCounter == int.from_bytes(fileSize, "big")):
        doneSending = True

print("Done programming")
port.read(1)
print("\nSerial monitor:")

while True:
    rcv = port.read(1)
    try:
        print(rcv.decode("utf-8"), end = '', flush=True)
    except:
        print(rcv, end = '', flush=True)