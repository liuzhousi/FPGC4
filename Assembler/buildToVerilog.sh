# Build script for assembly files
if (python3 Assembler.py > ../Programmer/code.list) # compile and write to code.list in Programmer folder
   then
   		# convert list to binary files, then copy the files to verilog folder
       	(cd ../Programmer && bash compileROM.sh && cp rom.bin  ../Verilog/memory/rom.bin && echo "Compile and Copy done")
       	# convert to text file
		(cd ../Verilog/memory && bash bin2txt.sh && echo "Converted to txt")
   else
   		# print the error, which is in code.list
       	(cat ../Programmer/code.list)
fi
