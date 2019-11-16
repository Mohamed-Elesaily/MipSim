import 'dart:async';
import 'dart:convert';

import 'dart:io';

String setPc(){
   
   String pc;
   new File('pc.txt').readAsString().then((String contents) {
    pc = contents;
  });
  return pc;
  }
