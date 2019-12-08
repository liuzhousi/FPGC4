python3 Assembler.py > ../Programmer/code.list # compile and write to code.list in Programmer folder
(cd ../Programmer && bash compileROM.sh && cp rom.bin  ../Verilog/memory/rom.bin && echo "Compile and Copy done") # convert list to binary files, then copy the files to verilog folder
(cd ../Verilog/memory && bash bin2txt.sh && echo "Converted to txt") # convert to text file
