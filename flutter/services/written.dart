
import 'dart:convert';
import 'dart:io';
bool isLoading=true;
  List<String>code =[];
 void getCode(List<String> a) {
    code.clear();
    final memory = new File('assembly.txt');
    memory.openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((l){
      code.add(l);
    });
     isLoading=false;
  }

  void c(){
    getCode(code);
  }  