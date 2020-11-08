# WSL1 version. Deamon thread stops automatically when program stops
# I do not expect this to happen on "real" linux

import serial
from time import sleep
import sys
import fileinput
import os
from tqdm import tqdm


#len(sys.argv)
#str(sys.argv)

port = serial.Serial("/dev/ttyUSB0", baudrate=115200, timeout=None)





"""
SENDING PROGRAMMER BINARY TO FPGC4
"""


sleep(0.3) # give the FPGC time to reset, even though it also works without this delay

# parse byte file
ba = bytearray()

with open("flasher.bin", "rb") as f:
    bytes_read = f.read()
    for b in bytes_read:
        ba.append(b)

# combine each 4 bytes into a word
n = 4
wordList = [ba[i * n:(i + 1) * n] for i in range((len(ba) + n - 1) // n )]  

# size of program is in address 5
fileSize = bytes(wordList[5])

#print(int.from_bytes(fileSize, "big"), flush=True)

print("Writing flash programmer to FPGC4")

# write filesize
port.write(fileSize)

# read four bytes
rcv = port.read(4)

# to verify if communication works
#print(rcv, flush=True)


# send all words
doneSending = False

wordCounter = 0

while not doneSending:
    port.write(bytes(wordList[wordCounter]))
    wordCounter = wordCounter + 1

    if (wordCounter == int.from_bytes(fileSize, "big")):
        doneSending = True

port.read(1) # should return 'd', though I'm not checking on it
print("Done programming FPGC4", flush=True)




"""
INTERACTING WITH PROGRAMMER
"""


def sendSingleByte(b):
    port.write(b)
    sleep(0.001) # give FPGC4 time to process byte


def eraseBlock(addr):
    port.read(1) # should return 'r', to indicate ready to accept command

    sendSingleByte( 'e'.encode('utf-8') )

    size = 0

    blist = size.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    blist = addr.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    sendSingleByte( '\n'.encode('utf-8') )

    #print("block erased")



def fillBuffer(page):

    port.read(1) # should return 'r', to indicate ready to accept command

    sendSingleByte( 'b'.encode('utf-8') )

    size = 0
    addr = 0

    blist = size.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    blist = addr.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    sendSingleByte( '\n'.encode('utf-8') )


    # command is sent, now wait for 'b' to write 256 bytes
    port.read(1)

    for i in range(256):
        sendSingleByte(page[i].to_bytes(1, byteorder="big"))

    #print("page sent")


def writeBuffer(addr):
    port.read(1) # should return 'r', to indicate ready to accept command

    sendSingleByte( 'w'.encode('utf-8') )

    size = 0

    blist = size.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    blist = addr.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    sendSingleByte( '\n'.encode('utf-8') )

    #print("page written")


def writePage(page, addr):
    fillBuffer(page) # fill buffer with page
    writeBuffer(addr) # tell FPGC4 to write the buffer to addr
    


def readFlash(size, addr, filename):
    port.read(1) # should return 'r', to indicate ready to accept command

    sendSingleByte( 'r'.encode('utf-8') )

    blist = size.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    blist = addr.to_bytes(3, byteorder="big")
    for b in blist:
        sendSingleByte(b.to_bytes(1, byteorder="big"))

    sendSingleByte( '\n'.encode('utf-8') )

    with open(filename, 'wb') as f:
        for i in tqdm(range(size)):
            rcv = port.read(1)
            f.write(rcv)

    #print("read done")


# Writes inFile to addr.
# If verify, then read and dump to outFile and diff on inFile and outFile
def writeFlash(inFile, addr = 0, verify = False, outFile = "verify.bin"):
    # get size of inFile
    size = os.stat(inFile).st_size

    print("Going to write " + str(size) + " bytes")

    # erase before programming
    blocksToErase = -(-size // 32768) # number of 32KiB blocks to erase

    blocksErased = 0

    for i in range(blocksToErase):
        eraseBlock(i*32768)
        blocksErased+=1

    print("Erased " + str(blocksErased) + " blocks")


    # get bytes to write
    ba = bytearray()
    # read binary file to byte array
    with open(inFile, "rb") as f:
        bytes_read = f.read()
        for b in bytes_read:
            ba.append(b)


    print("Writing pages")

    # loop in chunks of 256 bytes
    chunk_size= 256
    for i in  tqdm(range(0, len(ba), chunk_size)):
        chunk = ba[i:i+chunk_size]

        # write chunk
        writePage(chunk, addr)
        #print('.' , end = '', flush=True)
        addr = addr + 256

    print()

    # verify
    if verify:
        print("Reading data to verify")
        readFlash(size, 0, outFile)
        if os.system("diff " + inFile + " " + outFile):
            print("ERROR: WRITE FAILED!")
        else:
            print("Write successful")
        



print()
print("---FPGC4 FLASH PROGRAMMER---")


#readFlash(2048, 0, "dump.bin")

writeFlash("midiSynth.bin", 0, True)


"""

while True:
    bytesToRead = port.in_waiting
    if(bytesToRead > 0):
        rcv = port.read(1)
        try:
            print(rcv.encode('hex'), end = '', flush=True)
        except:
            print(rcv, end = '', flush=True)
    else:
        sleep(.01) # allow CPU to idle

"""