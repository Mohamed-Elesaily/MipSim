

import 'dart:io';
import 'package:example_flutter/widgets/Bar.dart';
import 'package:flutter/material.dart';

class Pc  extends StatefulWidget {
  
 
  @override
  _PcState createState() => _PcState();
}

class _PcState extends State<Pc> {
 String _pc;
  bool _isLoading=true;
  _getData()async{
     await  File('pc.txt').readAsString().then((String contents) {
    _pc = contents;
  });
    setState(() {_isLoading=false;});
  }
  @override
  void initState(){
    super.initState();
    _getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Bar(),
      appBar: AppBar(
         centerTitle: true,
        title: Text('Pc'),
      ),
      body:_isLoading? Center(
        child: CircularProgressIndicator(),
      ):Center(
        child: Column(
        
          children: <Widget>[
          
            Text('Pc',
            style:TextStyle(
              fontSize: 200,
              color: Colors.grey
            )
            ),
            Expanded( 
              child:Text('$_pc',
            style:TextStyle(
              fontSize: 150,
              color: Colors.grey
            )
            ),           
            )
             

          ],
        ),
        
      )
    );
  }
}