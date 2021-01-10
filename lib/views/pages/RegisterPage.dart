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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/background.png'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('Register Page')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 40.0),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/logo-primary-croped.PNG'),
                      fit: BoxFit.cover
                    )
                  ),
                )
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: "Email",
                          hintText: 'Masukan email Anda',
                          border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }

                            return null;
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.account_box),
                            labelText: 'Username',
                            hintText: 'Masukan username Anda',
                            border: const OutlineInputBorder(),
                          ),
                        )
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
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
                    )
                  )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage()));
                      }
                  },
                  child: Text('Daftar Akun')
              )
            ],
          )
        )
      )
    );
  }
}
