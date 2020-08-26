import mido
import sys

#mid = mido.MidiFile('mario.mid')
mid = mido.MidiFile(sys.argv[1])

msgList = []

for msg in mid:
    if msg.type == 'note_on' or msg.type == 'note_off':
        msgList.append(msg)



'''smallMsgList = []


for i in range(32):
    smallMsgList.append(msgList[i])'''

"""
noteList = []
for msg in msgList:
    print(msg.bytes())
    exit()
  

"""
print("MUSICNOTES:")
print("; midi data")
print(".dw ", end = '')
for idx, x in enumerate(msgList):
    if (idx%20 == 19):
        print("\n.dw ", end = '')

    print(x.bytes()[0], end = ' ')
    print(x.bytes()[1], end = ' ')
    print(x.bytes()[2], end = ' ')

print("\n")

print("MUSICLENS:")
print("; delaytimes")
print(".dw ", end = '')
for idx, x in enumerate(msgList):
    if (idx%20 == 19):
        print("\n.dw ", end = '')
    intLen = int(x.time*1000)
    if (intLen) == 0:
        intLen = 1
    print(intLen, end = ' ')

print()
