import 'dart:convert';
import 'dart:io';


import 'package:example_flutter/services/register.dart';
import 'package:example_flutter/widgets/Bar.dart';
import 'package:flutter/material.dart';



class Register extends StatefulWidget{
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String>_regContent =[];

  _getData() async {
    
    _regContent.clear();
    final register = new File('register.txt');
    await register.openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((l){
      _regContent.add(l);
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
        title: Text('Register'),
        
      ),
      body: ListView.builder(
        itemCount: _regContent.length,
        itemBuilder: (BuildContext context, index){
          return Card(
                      child: ListTile(
              title:Text('${reg[index]}: ${_regContent[index]}'),

            ),
          );
        },
      )
      
    );
  }
}