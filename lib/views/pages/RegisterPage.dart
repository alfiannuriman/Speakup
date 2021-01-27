import 'package:flutter/material.dart';
import 'package:speakup/views/pages/HomePage.dart';

import 'package:speakup/services/API.dart';
import 'package:speakup/services/register.dart';
import 'package:speakup/model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


final _userController = TextEditingController();
final _passwordController = TextEditingController();
final _emailController = TextEditingController();

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  snackbarAlert(String alertText) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: Colors.red,
              size: 16,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: MediaQuery.of(context).size.width / 1.5,
            child: Text(
              alertText,
              style: TextStyle(fontSize: 14.0),
            ),
          )
        ],
      ),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('images/background.png'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Register Page')),
        body: SingleChildScrollView(
          child: Center(
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
                          controller: _emailController,
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
                            controller: _userController,
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
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        obscureText: true,
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
                      doRegister();
                    }
                  },
                  child: Text('Daftar Akun')
                )
              ],
            )
          ),
        )
      )
    );
  }

  void doRegister() {
    String email = _emailController.text;
    String username = _userController.text;
    String password = _passwordController.text;

    fetchPostRegister(http.Client(), email, username, password, context)
        .then((onValueLogin) {
      try{
        if (onValueLogin.data != null) {
          snackbarAlert("Register Berhasil");
          _passwordController.text = "";
          Navigator.pushReplacement(
              context, MaterialPageRoute(
              builder: (BuildContext context) => HomePage()));
        } else {
          Navigator.of(context).pop();
          snackbarAlert("Terjadi Kesalahan");
        }
      }catch(Exception){
        //Navigator.of(context).pop();
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }
}
