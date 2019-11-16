import 'dart:convert';
import 'dart:io';
import 'package:example_flutter/services/memory.dart';
import 'package:example_flutter/widgets/Bar.dart';
import 'package:flutter/material.dart';


class Inst extends StatefulWidget {
 
  @override
  _Inst createState() => _Inst();
}

class _Inst extends State<Inst> {
  
  List<String> _memory=[]; 
  _getData() async{
    _memory.clear();
    final memory = new File('machine.txt');
   await memory.openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((l){
      _memory.add(l);
    });
    setState(() {
      
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Bar(),
      appBar: AppBar(
         centerTitle: true,
        title: Text('Instruction memory'),
        

      ),
      
      body:  ListView.builder(
        itemCount: _memory.length,
        itemBuilder: (BuildContext context, index){
          return Card(
                    child: ListTile(
                    title:Text('${index*4}:  ${_memory[index]} '),
                  ),
          );
        
        },
      )
      
    );
  }
}