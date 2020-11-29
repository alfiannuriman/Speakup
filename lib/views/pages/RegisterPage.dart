import 'package:flutter/material.dart';
import 'package:speakup/views/pages/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Register Page')),
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
                              icon: Icon(Icons.account_box),
                              labelText: 'Full name',
                              hintText: 'Enter your full name',
                              border: const OutlineInputBorder(),
                            ),
                          )),
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
                              icon: Icon(Icons.wc),
                              labelText: 'Gender',
                              hintText: 'Enter your gender',
                              border: const OutlineInputBorder(),
                            ),
                          )),
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
                          MaterialPageRoute(builder: (context) => LoginPage())
                        );                        
                      }
                    },
                    child: Text('Register'))
              ],
            )));
  }
}
