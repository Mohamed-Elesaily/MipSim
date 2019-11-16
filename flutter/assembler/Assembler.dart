import 'dart:io';
import 'package:example_flutter/widgets/Bar.dart';
import 'package:flutter/material.dart';
String content='';
class Assembler extends StatelessWidget {
  
  final _myController = TextEditingController();
  final _code = 'assembly.txt'; 
  final _pc = new File('pc.txt');
  @override

  Widget build(BuildContext context) {
    return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.play_arrow),
                onPressed: () {
                  print(_myController.text);
                  //________get text from textFeild__________//
                  File(_code).writeAsString(_myController.text);
                  _pc.readAsString().then((contents) {
                        content = contents;
                       print(contents);
                  });
                   //run command.py that contain 
                 /**
                  * run testbench
                  * convert.py
                  *   -convert register1.txt, memory1.txt and pc1.txt to decimal
                  * Assembler
                  * gtkwave to simulate
                  */


                
                  Process.run('python', ['command.py']);
                }),
            drawer:Bar(),
            appBar: AppBar(
              title: Text('Mips Assembler'),
              
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.autorenew),
                  iconSize: 50,
                  onPressed: () {
                     Navigator.pushNamed(context, '/a');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.video_library),
                  iconSize: 50,
                  onPressed: () {
                      Process.run('vlc', ['m.mp4']);
                  },
                ),
              ],
            ),
            body: ListView(children: <Widget>[
              TextField(
                controller: _myController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Input Assembly code',
                ),
              ),
            ]));
            
  }
}