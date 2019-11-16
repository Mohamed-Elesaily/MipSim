import 'package:example_flutter/widgets/Bar.dart';
import 'package:flutter/material.dart';

class PipeLine extends StatefulWidget {
  @override
  _PipeLineState createState() => _PipeLineState();
}

class _PipeLineState extends State<PipeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Bar() ,
      
    );
  }
}