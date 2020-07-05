#!/bin/bash

retList=()
# loop though c file arguments, compile them and run them
for filename in "$@"
do
    echo "Processing: $filename"
    # for each c file, compile and run
    echo "Compiling C code to B332 ASM"
    if (python3 B322_shivyC.py $filename > ../Assembler/code.asm) # compile c code and write compiled code to code.asm in Assembler folder
    then
        echo "C code successfully compiled"

        echo "Assembling B332 ASM code"
        if (cd ../Assembler && python3 Assembler.py > ../Programmer/code.list) # compile and write to code.list in Programmer folder
        then
                echo "B332 ASM code successfully assembled"
                # convert list to binary files and send to FPGC4
                (cd ../Programmer && bash compileROM.sh && echo "Sending binary to FPGC4" && powershell.exe "python uartFlasher_win.py testMode; exit \$LASTEXITCODE ")
                retVal="$?"
                echo "$filename exited with code: $retVal"
                retList+=("$retVal")

        else # assemble failed, run again to show error
            echo "Failed to assemble B332 ASM code"
            cd ../Assembler && python3 Assembler.py
        fi
    else # compile failed, run again to show error
        echo "Failed to compile C code"
        python3 B322_shivyC.py $filename
    fi
done

echo "Got the follwing return values:"
echo ${retList[@]} 