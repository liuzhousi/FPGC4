import serial
from time import sleep
import sys
import fileinput

stop_threads = False


port = serial.Serial("/dev/ttyUSB0", baudrate=115200, timeout=None)

sleep(0.3) # give the FPGC time to reset, even though it also works without this delay

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

print("Done programming FPGC4", flush=True)
port.read(1) # should return 'd', though I'm not checking on it

print("Waiting for FPGC4 to accept commands")
port.read(1)

print("Sending Read command")





def sendSingleByte(b):
    port.write(b)
    sleep(0.01)

def readFlash(size, addr):
    sendSingleByte( 'r'.encode('utf-8') )

    blist = size.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    blist = addr.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    sendSingleByte( '\n'.encode('utf-8') )

    sleep(0.01)

    with open('dump.bin', 'wb') as f:
        for i in range(size):
            rcv = port.read(1)
            f.write(rcv)

    print("read done")




readFlash(49152, 0)
