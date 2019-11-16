
import 'dart:io';

import 'package:example_flutter/assembler/Assembler.dart';
import 'package:example_flutter/inst/Inst.dart';
import 'package:example_flutter/pc/Pc.dart';
import 'package:example_flutter/register/Register.dart';
import 'package:example_flutter/services/memory.dart';
import 'package:example_flutter/written/Written.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'autotest/Auto.dart';
import 'memory/Memory.dart';

void main() {
  // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
 
  runApp(
  new MyApp()

  );
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          '/':(context)=> Assembler(),
          '/memory':(context)=> Memory(),
          '/register':(context)=> Register(),
          '/pc':(context)=> Pc(),
          '/w':(context)=>Written(),
          '/a':(context)=>Auto(),
          '/inst':(context)=>Inst(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(accentColor: Colors.green, primaryColor: Colors.green),
        title: 'Mips Assembler',
      
        );
  }
}
