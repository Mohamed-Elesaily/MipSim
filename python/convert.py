fileopen = open("pc1.txt",'r')
pc =fileopen.readlines()
s = pc[-1]
file =open("pc.txt",'w')
file.write(str(int(pc[-1],2)))
file.close()
fileopen.close()

fileopen = open("register1.txt",'r')
file = open("register.txt",'w')
pc =fileopen.readlines()
for i in pc:
    if i[0] == 'x':
        file.write('x\n')
       
    else:
        file.write(str(int(i,2)))  
        file.write("\n")          
file.close()
fileopen.close()
fileopen = open("memory1.txt",'r')
file = open("memory.txt",'w')
pc =fileopen.readlines()
for i in pc:
    if i[0] == 'x':
        file.write('x\n')
    else:
        
        file.write(str(int(i,2)))  
        file.write("\n")          
file.close()
fileopen.close()