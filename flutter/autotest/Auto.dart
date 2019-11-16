import 'dart:convert';
import 'dart:io';

import 'package:example_flutter/widgets/Bar.dart';
import 'package:flutter/material.dart';

class Auto extends StatefulWidget {
  @override
  _AutoState createState() => _AutoState();
}

class _AutoState extends State<Auto> {
  List<String> _checks=[];
  bool _loading = false;
  _getData()async{
    _checks.clear();
    await File('checker.txt').openRead()
    .transform(utf8.decoder)
    .transform(new LineSplitter())
    .forEach((l){
      _checks.add(l);
       
    });
    setState(() {
      _loading = true;
     
    });
  }
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getData();
    
  // }
  Widget _checkShape(int index){
    
      if(_checks[index]=='1'){
        return  Card(
           
            child: CircleAvatar(
              child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            )
        );
      }else if(_checks[index]=='0'){
      return Card(
           
            child: CircleAvatar(
              child: Text(
              "X",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white
              ),
            ),
            backgroundColor: Colors.red,
            )
        );
      }else{
        return CircularProgressIndicator();
      }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed:(){
          Process.run('python', ['commandauto.py']);
         
        } ,
      ),
      drawer: Bar(),
      appBar: AppBar(
        title: Text('Checker'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: (){
              _getData();
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount:_checks.length,
        itemBuilder: (BuildContext context,index){
         return _checkShape(index);
        }
     
      ),
        
    
    );

  }
}