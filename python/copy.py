import shutil
import sys
memory = "memory1.txt"
register = "register1.txt"

distreg = sys.argv[1]
distmem = sys.argv[2]
shutil.copyfile(register,distreg)
shutil.copyfile(memory,distmem)

