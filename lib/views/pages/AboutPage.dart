import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('About page')),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              const Text.rich(
                TextSpan(
                    text:
                        '       Speak Up Adalah aplikasi untuk anda anda yang ingin berbicara lebih lantang di dunia maya. Suara anda akan terdengar oleh teman teman yg anda inginkan. Ekspresikan suara anda di',
                    style: TextStyle(fontSize: 20)),
              ),
              Text('"Speak Up"',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  )),
              Text('Copyright by :', style: TextStyle(fontSize: 20)),
              Text('Muchamad Alfian Nur Iman -',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('18111215',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Firman Muhammad Ikhsan -',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('18111197',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Joko Nugroho -',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('18111205',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Dena Yuda Alamsyah -',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('18111189',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ])));
  }
}
