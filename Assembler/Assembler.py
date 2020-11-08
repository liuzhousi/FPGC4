#!/usr/bin/env python3

import sys
import CompileInstruction

#List of already inserted libraries. 
#To prevent multiple insertions of the same library.
#Global to allow access in recursion
libraryList = []

def parseLines(fileName):
    parsedLines = []
    with open(fileName, 'r') as f:
        for i, line in enumerate(f, start=1):
            # do something special in case of a .ds instruction
            if (len(line) > 4 and line.split(" ",maxsplit=1)[0] == ".ds"):
                parsedLines.append((i, ['.ds', line.split(" ",maxsplit=1)[1].rstrip('\n')]))
            else:
                parsedLine = line.strip().split(";",maxsplit=1)[0].split()
                if (parsedLine != []):
                    parsedLines.append((i, parsedLine))
    return parsedLines

def insertLibraries(parsedLines):
    returnList = []
    returnList.extend(parsedLines)

    for line in parsedLines:
        if (len(line[1]) == 2):
            if (line[1][0]) == "`include":
                if (line[1][1] not in libraryList):
                    libraryList.append(line[1][1])
                    insertList = insertLibraries(parseLines(line[1][1])) #recursion to include libraries within libraries
                    for i in range(len(insertList)): 
                        returnList.insert(i, insertList[i]) 

    return returnList


def compileLine(line):
    compiledLine = ""

    #check what kind of instruction this line is
    switch = {
        "halt"      : CompileInstruction.compileHalt,
        "read"      : CompileInstruction.compileRead,
        "write"     : CompileInstruction.compileWrite,
        "copy"      : CompileInstruction.compileCopy,
        "push"      : CompileInstruction.compilePush,
        "pop"       : CompileInstruction.compilePop,
        "jump"      : CompileInstruction.compileJump,
        "jumpo"     : CompileInstruction.compileJumpo,
        "jumpr"     : CompileInstruction.compileJumpr,
        "jumpro"    : CompileInstruction.compileJumpro,
        "load"      : CompileInstruction.compileLoad,
        "loadhi"    : CompileInstruction.compileLoadhi,
        "beq"       : CompileInstruction.compileBeq,
        "bne"       : CompileInstruction.compileBne,
        "bgt"       : CompileInstruction.compileBgt,
        "bge"       : CompileInstruction.compileBge,
        "savpc"     : CompileInstruction.compileSavpc,
        "reti"      : CompileInstruction.compileReti,
        "or"        : CompileInstruction.compileOr,
        "and"       : CompileInstruction.compileAnd,
        "xor"       : CompileInstruction.compileXor,
        "add"       : CompileInstruction.compileAdd,
        "sub"       : CompileInstruction.compileSub,
        "shiftl"    : CompileInstruction.compileShiftl,
        "shiftr"    : CompileInstruction.compileShiftr,
        "mult"      : CompileInstruction.compileMult,
        "not"       : CompileInstruction.compileNot,
        "addr2reg"  : CompileInstruction.compileAddr2reg,
        "load32"    : CompileInstruction.compileLoad32,
        "nop"       : CompileInstruction.compileNop,
        ".dw"       : CompileInstruction.compileDw,
        ".dd"       : CompileInstruction.compileDd,
        ".db"       : CompileInstruction.compileDb,
        ".ds"       : CompileInstruction.compileDs,
        "loadlabellow" : CompileInstruction.compileLoadLabelLow,
        "loadlabelhigh" : CompileInstruction.compileLoadLabelHigh,
        "readintid" : CompileInstruction.compileReadIntID,
        "`include" : CompileInstruction.compileNothing
    }


    try:
        compiledLine = switch[line[0].lower()](line)

    #print errors
    except KeyError:
        #check if line is a label
        if len(line) == 1 and line[0][-1] == ':':
            compiledLine = "Label " + str(line[0])
        #if not a label, raise error
        else:
            raise Exception("Unknown instruction '" + str(line[0]) + "'" )

    return compiledLine

#compiles lines that can be compiled directly
def passOne(parsedLines):
    passOneResult = []

    for line in parsedLines:
        try:
            compiledLine = compileLine(line[1])

            #fix instructions that have multiple lines

            if compiledLine.split()[0] == "loadBoth":
                passOneResult.append((line[0], compileLine(["load", compiledLine.split()[2], compiledLine.split()[3]])))
                compiledLine = compileLine(["loadhi", compiledLine.split()[1], compiledLine.split()[3]])

            if compiledLine.split()[0] == "loadLabelHigh":
                passOneResult.append((line[0], "loadLabelLow " + " ".join(compiledLine.split()[1:])))

            if compiledLine.split()[0] == "data":
                for i in compiledLine.split():
                    if i != "data":
                        passOneResult.append((line[0], i + " //data"))
            else:
                if (compiledLine != "ignore"):
                    passOneResult.append((line[0], compiledLine))
        except Exception as e:
            print("Error in line " + str(line[0]) + ": " + " ".join(line[1]))
            print("The error is: {0}".format(e))
            print("Assembler will now exit")
            sys.exit(1)

    return passOneResult

#reads and removes define statements, stores them into dictionary
def obtainDefines(content):
    defines = {} #list of definitions with their value

    contentWithoutDefines = [] #lines without defines
    defineLines = [] #lines with defines

    #seperate defines from other lines
    for line in content:
        if line[1][0].lower() == "define":

            #do error checking
            if len(line[1]) != 4 or line[1][2] != "=":
                print("Error in line " + str(line[0]) + ": " + " ".join(line[1]))
                print("Invalid define statement")
                print("Assembler will now exit")
                sys.exit(1)

            defineLines.append(line)
        else:
            contentWithoutDefines.append(line) 

    #parse the lines with defines
    for line in defineLines:
        if (line[1][1] in defines):
            print("Error: define " + line[1][1] + " is already defined")
            print("Assembler will now exit")
            sys.exit(1)
        defines.update({line[1][1]:line[1][3]})

    return defines, contentWithoutDefines


#replace defined words with their value
def processDefines(defines, content):
    replacedContent = [] #lines where defined words have been replaced

    #for each line, replace the words with their corresponding value if defined
    for line in content:
        replacedContent.append((line[0], [defines.get(word, word) for word in line[1]]))

    return replacedContent

#adds interrupts and jump to main
def addHeaderCode(parsedLines):
    header = [(0,"jump Main"),(0,"jump Int1"),(0,"jump Int2"),(0,"jump Int3"),(0,"jump Int4"), (0,"LengthOfProgram")]
    
    return header + parsedLines

#move labels to the next line
def moveLabels(parsedLines):
    returnList = []

    #move to next line
    # (old iteration) for idx, line in enumerate(parsedLines):
    idx = 0;
    while idx < len(parsedLines):
        line = parsedLines[idx]
        if line[1].lower().split()[0] == "label":
            if idx < len(parsedLines) - 1:
                # if we have a label directly below, insert a nop as a quick fix
                if parsedLines[idx+1][1].lower().split()[0] == "label":
                    parsedLines.insert(idx+1, (0, "_*" + line[1].split()[1] + "*_ " +"00000000000000000000000000000000 //NOP to quickfix double labels"))
                else:
                    parsedLines[idx+1] = (parsedLines[idx+1][0], "_*" + line[1].split()[1] + "*_ " + parsedLines[idx+1][1])
            else:
                print("Error: label " + line[1].split()[1] + " has no instructions below it")
                print("Assembler will now exit")
                sys.exit(1)
        idx += 1

    #remove original labels
    for line in parsedLines:
        if line[1].lower().split()[0] != "label":
            returnList.append(line)

    return returnList


#renumbers each line
def redoLineNumbering(parsedLines):
    returnList = []

    for idx, line in enumerate(parsedLines):
        returnList.append((idx, line[1]))

    return returnList

#removes label prefix and returns a map of labels to line numbers
def getLabelMap(parsedLines):
    labelMap = {}
    returnList = []

    for line in parsedLines:
        if line[1].split()[0][:2] == "_*" and line[1].split()[0][-3:] == ":*_":
            if (line[1].split()[0][2:-3] in labelMap):
                print("Error: label " + line[1].split()[0][2:-3] + " is already defined")
                print("Assembler will now exit")
                sys.exit(1)

            labelMap[line[1].split()[0][2:-3]] = line[0]


    for line in parsedLines:
        if line[1].split()[0][:2] == "_*" and line[1].split()[0][-2:] == "*_":
            returnList.append((line[0], line[1].split("*_ ", maxsplit=1)[1]))
        else:
            returnList.append(line)

    return returnList, labelMap

#compiles all labels
def passTwo(parsedLines, labelMap):
    #lines that start with these names should be compiled
    toCompileList = ["jump", "beq", "bne", "bgt", "bge", "loadlabellow" ,"loadlabelhigh"]

    for idx, line in enumerate(parsedLines):
        if line[1].lower().split()[0] in toCompileList:
            for idx2, word in enumerate(line[1].split()):              
                if word in labelMap:
                    x = line[1].split()
                    x[idx2] = str(labelMap.get(word))
                    y = compileLine(x)
                    parsedLines[idx] = (parsedLines[idx][0], y)
                 

    return parsedLines

#check if all labels are compiled
def checkNoLabels(parsedLines):
    toCompileList = ["jump", "beq", "bne", "bgt", "bge", "loadlabellow" ,"loadlabelhigh"]
    
    for idx, line in enumerate(parsedLines):
        if line[1].lower().split()[0] in toCompileList:
            labelPos = 0
            if line[1].lower().split()[0] in ["jump", "loadlabellow" ,"loadlabelhigh"]:
                labelPos = 1
            if line[1].lower().split()[0] in ["beq", "bne", "bgt", "bge"]:
                labelPos = 3
            print("Error: label " + line[1].split()[labelPos] + " is undefined")
            print("Assembler will now exit")
            sys.exit(1)

        if line[1].lower().split()[0] == "label":
            print("Error: label " + line[1].split()[1] + " is used directly after another label")
            print("Assembler will now exit")
            sys.exit(1)
        


def main():

    #parse lines from file
    parsedLines = parseLines("code.asm")

    #insert libraries
    parsedLines = insertLibraries(parsedLines)

    #obtain and remove the define statements
    defines, parsedLines = obtainDefines(parsedLines)

    #replace defined words with their value
    parsedLines = processDefines(defines, parsedLines) 

    #do pass one
    passOneResult = passOne(parsedLines)

    #add interrupt code and jumps
    passOneResult = addHeaderCode(passOneResult)

    #move labels to the next line
    passOneResult = moveLabels(passOneResult)

    #redo line numbers for jump addressing
    #from this point no line should become multiple lines in the final code!
    #also no shifting in line numbers!
    passOneResult = redoLineNumbering(passOneResult)

    #removes label prefixes and creates mapping from label to line
    passOneResult, labelMap = getLabelMap(passOneResult) 

    #do pass two
    passTwoResult = passTwo(passOneResult, labelMap)

    #check if all labels are processed
    checkNoLabels(passTwoResult)

    lenString = '{0:032b}'.format(len(passTwoResult)) + " //Length of program"
    #calculate length of program
    passTwoResult[5] = (5, lenString)

    #print result without line numbers
    for line in passTwoResult:
        print(line[1])

if __name__ == '__main__':
    main()