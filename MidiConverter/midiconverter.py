import mido

#mid = mido.MidiFile('mario.mid')
mid = mido.MidiFile('sanic2.mid')

msgList = []

for msg in mid:
    if msg.type == 'note_on' or msg.type == 'note_off':
        msgList.append(msg)


'''smallMsgList = []


for i in range(32):
    smallMsgList.append(msgList[i])'''


noteList = []
for msg in msgList:
    if msg.note not in noteList:
        noteList.append(msg.note)
noteList.sort()


def getAbsList(msgList):
    absList = []

    abstime = 0

    for msg in msgList:
        abstime = abstime + msg.time
        absList.append((abstime, msg.type, msg.note))
            
    return absList

absList = getAbsList(msgList)
    

noteDict = {}
for note in noteList:
    noteDict[note] = 0

timeStatusList = []

currentTime = 0
for x in absList:
    if x[0] != currentTime:
        timeStatusList.append((currentTime, noteDict.copy()))
        currentTime = x[0]
    if x[1] == 'note_on':
        noteDict[x[2]] = 1
    if x[1] == 'note_off':
        noteDict[x[2]] = 0
   

dtimeList = []
for idx, x in enumerate(timeStatusList):
    if idx + 1 < len(timeStatusList):
        dtimeList.append(timeStatusList[idx+1][0] - timeStatusList[idx][0])
#TODO: add length for last note!


noteOnList = []
for x in timeStatusList:
    onNotes = []
    for key, value in x[1].items():
        if value == 1:
            onNotes.append(key)
    noteOnList.append(onNotes)

#for i in noteOnList:
#    if len(i) > 4:
#        print("Got more than 4 notes at the same time!")
#        print("Program will exit now")
#        exit(1)

dtimeNoteList = []
for idx, t in enumerate(dtimeList):
    dtimeNoteList.append((dtimeList[idx], noteOnList[idx]))


print("; music note data")
print(".dw ", end = '')
for idx, x in enumerate(dtimeNoteList):
    if (idx%20 == 19):
        print("\n.dw ", end = '')

    print("0x", end = '')
    if len(x[1]) is not 0:
        noteCounter = 0
        for note in x[1]:
            if (noteCounter < 4):
                print("{:02x}".format(note - 19), end = '')
                noteCounter = noteCounter + 1
    else:
        print("0", end = '')
    print(" ", end = '')
    


    #print(noteHex, end = ' ')

print("\n")

print("; music duration data")
print(".dw ", end = '')
for idx, x in enumerate(dtimeNoteList):
    if (idx%20 == 19):
        print("\n.dw ", end = '')
    intLen = int(x[0]*1000)
    if (intLen) == 0:
        intLen = 1
    print(intLen, end = ' ')

print()
