
import 'dart:convert';
import 'dart:io';
bool memoryisLoading =true;
  List<String>elemnts =[];
 void setMemory(List<String> a) {
    elemnts.clear();
    final memory = new File('memory.txt');
    memory.openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((l){
      elemnts.add(l);
    });
   
  }

  void a(){
    setMemory(elemnts);
    //  memoryisLoading = false;
  }  