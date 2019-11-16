#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <bitset>
#include <map>
using namespace std;

int main(){
	string bit0 ="00000000000000000000000000000000";
	ifstream assembly{"assembly.txt"};
	if(!assembly){
		cerr << "Error opening Assembly.txt";
		return 1;
	}
	ofstream machine{"machine.txt"};
	if(!machine){
		cerr << "Error opening Machine.txt";
		return 1;
	}

	map<string,int> reg;
	reg["$zero"] = 0;		reg["$at"] = 1;			reg["$v0"] = 2;
	reg["$v1"] = 3;			reg["$a0"] = 4;			reg["$a1"] = 5;
	reg["$a2"] = 6;			reg["$a3"] = 7;			reg["$t0"] = 8;
	reg["$t1"] = 9;			reg["$t2"] = 10;		reg["$t3"] = 11;
	reg["$t4"] = 12;		reg["$t5"] = 13;		reg["$t6"] = 14;
	reg["$t7"] = 15;		reg["$s0"] = 16;		reg["$s1"] = 17;
	reg["$s2"] = 18;		reg["$s3"] = 19;		reg["$s4"] = 20;
	reg["$s5"] = 21;		reg["$s6"] = 22;		reg["$s7"] = 23;
	reg["$t8"] = 24;		reg["$t9"] = 25;		reg["$k0"] = 26;
	reg["$k1"] = 27;		reg["$gp"] = 28;		reg["$sp"] = 29;
	reg["$fp"] = 30;		reg["$ra"] = 31;

	map<string,int> opcode;
	opcode["addi"] = 8;		opcode["andi"] = 12;	opcode["beq"] = 4;
	opcode["bne"] = 5;		opcode["j"] = 2;		opcode["jal"] = 3;
	opcode["lb"] = 32;		opcode["lh"] = 33;		opcode["lui"] = 15;
	opcode["lw"] = 35;		opcode["ori"] = 13;		opcode["sb"] = 40;
	opcode["sh"] = 41;		opcode["slti"] = 10;	opcode["sw"] = 43;
	opcode["xori"] = 14;

	map<string,int> funct;
	funct["add"] = 32;		funct["and"] = 36;		funct["jr"] = 8;
	funct["nor"] = 39;		funct["or"] = 37;		funct["sll"] = 0;
	funct["slt"] = 42;		funct["sra"] = 3;		funct["srl"] = 2;
	funct["sub"] = 34;		funct["xor"] = 38;

	map<string,int> labels;
	int address = -1;
	string line;
	while(!assembly.eof()){
		++address;
		getline(assembly, line);

		if(line == "...")
			address = (address / 100 + 1) * 100 - 1;

		else if(line.find(":") != string::npos){
			while(line[0] == ' ')
				line.erase(0,1);
			while(line[line.find(":") - 1] == ' ')
				line.erase(line.find(":") - 1, 1);
			labels[line.substr(0, line.find(":"))] = address;
		}
	}
	address = -1;
	assembly.clear();
	assembly.seekg(0, ios::beg);

	while(!assembly.eof()){
		string label, op, rs = "$zero", rt = "$zero", rd = "$zero";
		int immediate, shamt = 0;
		char type;
		++address;
		getline(assembly, line);

		if(line == "..."){
			for(int last = (address / 100 + 1) * 100; address < last; ++address)
				machine << bit0 << endl;		//bitset<32>
			--address;
			continue;
		}
		else if(line.find("halt") != string::npos){
			machine << bitset<32>(-1) << endl;
			continue;
		}
		else if(line.find("nop") != string::npos){
			machine << bit0 << endl;		//bitset<32>
			continue;
		}

		if(line.find(":") != string::npos){
			line.erase(0, line.find(":") + 1);
		}
		if(line.find("$") != string::npos){
			line.insert(line.find("$") - 1, " ");
		}
		if(line.find("(") != string::npos){
			line[line.find("(")] = ' ';
		}
		if(line.find(")") != string::npos){
			line[line.find(")")] = ' ';
		}
		while(line.find(",") != string::npos){
			line[line.find(",")] = ' ';
		}
		while(line.find("  ") != string::npos){
			line.erase(line.find("  "), 1);
		}
		if(line[0] == ' ')			line.erase(0,1);
		istringstream instruction{line};
		instruction >> op;
		
		if(op == "add" || op == "and" || op == "nor" ||
			op == "or" || op == "slt" || op == "sub" || op == "xor"){
			instruction >> rd >> rs >> rt;
			type = 'R';
		}
		else if(op == "sll" || op == "srl" || op == "sra"){
			instruction >> rd >> rt >> shamt;
			type = 'R';
		}
		else if(op == "jr"){
			instruction >> rs;
			type = 'R';
		}
		else if(op == "j" || op == "jal"){
			instruction >> label;
			machine << bitset<6>(opcode[op]) << bitset<26>(labels[label]) << endl;
			continue;
		}
		else if(op == "lui"){
			instruction >> rt >> immediate;
			type = 'I';
		}
		else if(op == "addi" || op == "andi" || op == "ori" || op == "slti" || op == "xori"){
			instruction >> rt >> rs >> immediate;
			type = 'I';
		}
		else if(op == "lb" || op == "lh" || op == "lw"
			|| op == "sb" || op == "sh" || op == "sw"){
			instruction >> rt >> immediate >> rs;
			type = 'I';
		}
		else if(op == "beq" || op == "bne"){
			instruction >> rs >> rt >> label;
			immediate = labels[label] - address - 1;
			type = 'I';
		}

		if(type == 'I'){
			machine << bitset<6>(opcode[op]) << bitset<5>(reg[rs]);
			machine << bitset<5>(reg[rt]) << bitset<16>(immediate) << endl;
		}
		else{
			machine << bitset<6>(0) << bitset<5>(reg[rs]) << bitset<5>(reg[rt]);
			machine << bitset<5>(reg[rd]) << bitset<5>(shamt) << bitset<6>(funct[op]) << endl;
		}
	}
	
	while(address < 8191){
		machine << bit0 << endl;		//bitset<32>
		++address;
	}
	assembly.close();
	machine.close();
	return 0;
}
