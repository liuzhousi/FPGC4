# More about the project
In this section I give a more blog post like description of the project.

The FPGC4 (Field Programmable Game Console v4) is the fourth version of my game console/PC that is implemented in an FPGA. It runs on a self designed CPU called the B322 (B4rt 32 bit processor v2) and a self designed GPU called the FSX2 (Frame Synthesizer v2). It has the performance of a computer from the 1980's, but with some newer features like a 32 bit CPU architecture with an 0.5GiB address space, and a clock speed of 25MHz.

## Why?
Nowadays computers are so immensely complex that it is hard to understand how they actually work. There are so many layers of abstraction, like CPU Microcode, BIOS and the Operating System, that it is hard to imagine how things works at a low level. As a Computer Science student, I usually am only working on higher level software, and not on hardware. So to answer questions like "What does a CPU do at each clock cycle?", "How does a CPU access different kinds of memory with different latencies?", "How does the CPU talk to the GPU?" and "How does a GPU render an image on the display?", I started this project to design a computer myself. 

So the goal of this project is to understand how a computer works at a very low level, by designing and building one myself. 

## How?
Since I want to design my own hardware like a CPU and GPU, I need a way to actually build them. And since I do not own a factory that can make chips, and I do not want to buy and solder a bajillion transistors or logic ICs, I needed a magical device that allows me to create my own chips. Luckily, such magical device exists, and it is called an FPGA (Field Programmable Gate Array). An FPGA is a chip that consists out of many *configurable* logic building blocks. It usually has many pins to connect to other hardware, just like an Arduino. Aside from logic blocks, it usually also has some blocks of SRAM, and some other handy hardware like PLLs (for clock signal generation) and hardware multipliers. FPGAs are usually "programmed" using a hardware description language (HDL) like VHDL or Verilog. These languages allow you (but do not require you) to abstract a bit away from the flip-flops and logic gates, but not by much. They allow you to design pretty complex hardware while still giving the designer control about what happens at each clock cycle. The most important part of these HDLs, is that you can use a simulator to "see inside the chip" and see what signals are high or low at any point in time! For this project, I chose Verilog, since it looked a bit more like "normal" programming languages like C. Eventually, this appeared to be a good decision, since the simulation models of the SDRAM and SPI flash I used for this project were also written in Verilog.

## Performance
Because current computers are so complex, it would be unfeasible for me, with no prior hardware design experience, to design a fast computer that will eventually run Windows or Linux. So I focused more on PCs and game consoles from around 1980, like the Commodore 64 and Nintendo Entertainment System (NES), since those are a lot less complex than the ones we have now. Using an FPGA from somewhere around 2010 built on a 60nm process instead of a few um process from the 1980's, allows me to add some features that were not usual in the 1980's. So instead of an 8 bit CPU architecture, I chose for an 32 bit architecture, so I can add more stuff in each instruction, vastly increasing the throughput of the CPU. The FPGA also allows me to use a 25MHz clock instead of a 1MHz CPU like the Commodore 64 uses. My FPGA board also has a 32MiB SDRAM chip, which is a huge amount of memory compared to something like a Commodore 64 or NES. Furthermore, the 32 bit architecture allowed me to have a huge address space (currently 0.5GiB). It is important to note that because of the way I designed the architecture of the CPU and MU (Memory Unit), it is impossible to use pipelining to increase the performance. Complex tricks like pipelining and branch prediction were never the goal of this project and therefore will probably never be implemented.

So as a performance reference, one should expect something similar to a Commodore 64 or NES.

## FPGA Board
There are different FPGA chips from different vendors, and there are many different development boards. The one I chose for this project is the [Cyclone IV EP4CE15 Core Board with 32MiB SDRAM from QMtech from Aliexpress](https://www.aliexpress.com/i/32949281189.html). The old revision of this board uses SDRAM from Micron. This old revision is the board I initially designed this project for. The newer revision uses Winbond SDRAM. I currently use the newer revision board and the Winbond chip is completely compatible with my SDRAM controller.

## Full history of project
<details>
<summary>Warning: Very long and uninteresting text!</summary>
  
This project started around 2017 as the FPGC1, my first project on an FPGA. I just discovered that FPGAs were a thing and really wanted do learn how to use them. After some research I found that some people even recreated the entire NES in an FPGA! So I bought an Altera Cyclone IV EP4CE6 board from Aliexpress for 20 euros and decided I wanted to create some kind of game console myself, knowing it would be a very hard first project. I chose an Altera FPGA, since I heard that the IDE of Altera/Intel is subjectively better than Xilinx's IDE, though I probably would have chosen Altera anyways since their JTAG programmer has cheap clones you can buy for like 3 bucks. As of HDL choice, I thought Verilog looked a lot cleaner and more understandable than VHDL, so I chose Verilog. In contrast to software development, hardware development has a huge learning curve and requires a very different way of thinking, so my first project was not that much of a success if you look at the code. Most importantly, I did not know yet the importance of a simulator, so I did not simulate anything. I also did not know how to properly structure the code and that things like division and modulo do not translate well in hardware. However, I did learn a lot and that was the most important thing of the project.

About a year later, and some other simple FPGA projects later, I decided to make a better version of the FPGC, and so the FPGC2 was born. I still did not know how to use a simulator, so the project was a complete failure and never worked. After the failure of the FPGC2, I started working on some video conversion projects where I connect the FPGA to a Gameboy or Gameboy Advance, read the display signals to the LCD, store them in an dual port dual clock SRAM framebuffer (the easiest way), and display them on a CRT or VGA monitor. Those projects were kind of a success, since they did not really need simulator and were visually debuggable. 

Some time later, in the summer of 2019, I discovered the beauty of the simulator. Using the simulator I could write tests and look per cycle if the hardware does what I want it to do. Since this is perfect for designing a CPU, I decided to do another retake at the FPGC project. The newly designed FPGC3 was made with the mistakes from the FPGC1 and FPGC2 in mind. I became a lot better at thinking how a line of code would translate in hardware. Every part of the FPGC3 was verified in the simulator and worked pretty solid. Well, at least in the simulations it worked. When I finally synthesized the code and programmed in into the FPGA, things were starting to fall apart. Things did not work as they should according to the simulation. These kind of problems are one of the hardest to debug, since you cannot simulate it. Apparently, simulation cannot guarantee that a design works in hardware. After a LOT of reading about FPGA development online, I found out that there are a lot of things you should not do if you want your design to actually work in hardware. Things like clock domain crossing and timing constraints where new terms I learning during that time. Luckily I found out you can "register" a clock signal in Quartus (the Altera IDE) and that it can tell where timing constraints are not met. I started to understand why things did not work and that logic gates have setup and hold timings that they must meet. Most importantly, you have to be really careful when two parts are running on different clock frequencies. I still do not understand why this is not clearly stated in all FPGA tutorials, since the problems they cause is so dang hard to debug when you do not know what clock domains are.

After a few months of hard work, I finally had a solid design with a sprite/tile based GPU that was working pretty well. The program was executed from an SPI flash module that allowed me to change the program without recompiling the FPGA (which is slow). I eventually moved to the EP4CE15 board because it had more SRAM and I added I/O like a NES controller port and PS/2 keyboard port. I always had the struggle that the performance of the system was so severely bottlenecked by the SPI flash module, even in QSPI mode with continuous reading enabled. After considering all options for storage I decided that the SDRAM chip on the development board was the best solution. So I started to create an SDRAM controller. Luckily, there are many examples and tutorials on how to do this online, which really helped a lot, and in a day or two I had a basic but solid SDRAM controller that worked in simulation and hardware. At this point I wanted to redesign the FPGC around the SDRAM and rewrite many parts of the code using my improved Verilog skills. And so was the FPGC4 born.

The FPGC4 uses a bootloader to copy the program from SPI flash to SDRAM and executes everything from SDRAM. The most important new addition was the Memory Unit (MU), which allowed me to separate all memory and I/O from the CPU. While it does include one cycle of overhead, it made the entire project so much more modular and structured. The GPU has also been improved by a lot and can now actually render 64 sprites with 16 sprites on the same line, which is better that any game console from the 1980's that I am aware of. The video RAM is still SRAM, which forces me to use a tile/sprite based rendering technique, but I (currently) prefer this over a framebuffer based rendering technique. Other new things in the FPGC4 are sound, hardware timers and more I/O things like SPI and UART. I even made a UART bootloader for super fast programming (like an Arduino does).

Aside from FPGA programming, this project also includes some more software based sub-projects. To prevent having to write all my code by manually typing zeros and ones, I made an assembly language. And to compile the assembly back to zeros and ones, I made a compiler/assembler. I also created some scripts to convert graphics into tiles and MIDI into code. Eventually I decided to make a PCB for this project. This was a really fun learning experience, and luckily I have a dad that designs PCBs for work, so I got a lot of tips from him. After some weeks of designing, I finally created an order at JLCPCB in China to fabricate my PCB and ordered all the components I did not have already from Aliexpress. Currently, all orders are completed and the PCB is built. Everything works, I only made two mistakes: using pull downs instead of pull ups on the UART lines, and not connecting all shields to ground.
</details>