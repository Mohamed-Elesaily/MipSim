#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
using namespace std;

int main(){
	ofstream result{"checker.txt"};
	if(!result){
		cerr << "Error opening Check_Result.txt";
		return 1;
	}

	for(int i = 0; i < 10; ++i){
		bool correct = 1;
		ostringstream file_name;
		file_name << "tc" << i << "_reg_cor.txt";
		ifstream reg_cor{file_name.str()};
		if(!reg_cor){
			cerr << "Error opening " + file_name.str();
			return 1;
		}
		file_name.str("");
		file_name << "tc" << i << "_reg_out.txt";
		ifstream reg_out{file_name.str()};
		if(!reg_out){
			cerr << "Error opening " + file_name.str();
			return 1;
		}
		while(!reg_cor.eof() && !reg_out.eof()){
			string line_cor, line_out;
			reg_cor >> line_cor;
			reg_out >> line_out;
			if(line_cor == line_out)		continue;
			result << 0 << endl;
			correct = 0;
			break;
		}
		reg_cor.close();
		reg_out.close();

		if(correct){
			file_name.str("");
			file_name << "tc" << i << "_mem_cor.txt";
			ifstream mem_cor{file_name.str()};
			if(!mem_cor){
				cerr << "Error opening " + file_name.str();
				return 1;
			}
			file_name.str("");
			file_name << "tc" << i << "_mem_out.txt";
			ifstream mem_out{file_name.str()};
			if(!mem_out){
				cerr << "Error opening " + file_name.str();
				return 1;
			}
			while(!mem_cor.eof() && !mem_out.eof()){
				string line_cor, line_out;
				mem_cor >> line_cor;
				mem_out >> line_out;
				if(line_cor == line_out)		continue;
				result << 0 << endl;
				correct = 0;
				break;
			}
			if(correct)
				result << 1 << endl;
			mem_cor.close();
			mem_out.close();
		}
	}
	result.close();
    return 0;
}
