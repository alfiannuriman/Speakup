import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About page')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Copyright by :', style: TextStyle(fontSize: 20)),
            Text('Muchamad Alfian Nur Iman', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('18111215', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ]
        )
      )
    );
  }

}