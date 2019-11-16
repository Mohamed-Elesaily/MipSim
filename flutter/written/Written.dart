import 'package:example_flutter/services/written.dart';
import 'package:example_flutter/widgets/Bar.dart';
import 'package:flutter/material.dart';

class Written extends StatefulWidget 
{ 
  @override
  _WrittenState createState() => _WrittenState();
  
}

class _WrittenState extends State<Written> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Bar(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Written'),
          
        ),
        
        body:isLoading?Center(
          child: CircularProgressIndicator(),
        ): StatefulBuilder(
          builder: (BuildContext context, StateSetter c) {
            return ListView.builder(
              itemCount: code.length,
              itemBuilder: (BuildContext context, index) {
                return ListTile(
                  title: Text('$index  ${code[index]}'),
                );
              },
            );
          },
        ));
  }
}
