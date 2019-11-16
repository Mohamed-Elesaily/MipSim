import shutil
import sys
assembly = "assembly.txt"
distAss = sys.argv[1]
shutil.copyfile(distAss,assembly)
