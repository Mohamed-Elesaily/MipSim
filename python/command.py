import os
os.system("g++ main.cpp")
os.system("./a.out")
os.system("iverilog testbench-1.v -o m")
os.system("vvp m")
os.system("python convert.py")
os.system("gtkwave mips.vcd")

