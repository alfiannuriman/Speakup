import 'package:flutter/material.dart';
import 'package:speakup/views/pages/TimelinePage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login Page')),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone),
                            labelText: 'Phone number',
                            hintText: 'Enter your phone number',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock_rounded),
                              labelText: 'Password',
                              hintText: 'Enter secure password',
                              border: const OutlineInputBorder(),
                            ),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TimelinePage())
                        );
                      }
                    },
                    child: Text('Login'))
              ],
            )));
  }
}
