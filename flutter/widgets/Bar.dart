
import 'package:example_flutter/services/written.dart';
import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
              child: ListView(children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text('Menu',
                        style: TextStyle(fontSize: 50, color: Colors.white)),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                ),
                 Card(
                  child: ListTile(
                    title: Text('Assembler'),
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ),
                 Card(
                  child: ListTile(
                    title: Text('Instruction Memory'),
                    onTap: () {
                      Navigator.pushNamed(context, '/inst');        
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Memory File'),
                    onTap: () {
                      Navigator.pushNamed(context, '/memory');        
                    },
                  ),
                ),
                Card( 
                  child: ListTile(
                    title: Text('Register File'),
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Pc'),
                    onTap: () {
                       Navigator.pushNamed(context, '/pc');
                    },
                  ),
                ),
                
              Card(
                  child: ListTile(
                    title: Text('Written code'),
                    onTap: () {
                       Navigator.pushNamed(context, '/w');
                        getCode(code);
                    },
                  ),
                ),
                
              ]),
            );
  }
}