import serial

port = serial.Serial("/dev/ttyUSB0", baudrate=115200, timeout=10.0)


# parse byte file
ba = bytearray()

with open("code.bin", "rb") as f:
    bytes_read = f.read()
for b in bytes_read:
    ba.append(b)

n = 4

wordList = [ba[i * n:(i + 1) * n] for i in range((len(ba) + n - 1) // n )]  

fileSize = bytes(wordList[5])

print(int.from_bytes(fileSize, "big") )

#write filesize
port.write(fileSize)

#read four bytes
rcv = port.read(4)

print(rcv)


doneSending = False

wordCounter = 0

while not doneSending:
    #write word
    #print(bytes(wordList[wordCounter]))
    port.write(bytes(wordList[wordCounter]))
    wordCounter = wordCounter + 1
    #read one byte
    #rcv = port.read(1)
    #print(rcv)
    #print()

    #if (rcv == b'd'):
    if (wordCounter == int.from_bytes(fileSize, "big")):
        doneSending = True

print("Done programming")