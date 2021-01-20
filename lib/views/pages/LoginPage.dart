import 'package:flutter/material.dart';
import 'package:speakup/views/pages/TimelinePage.dart';

import 'package:speakup/services/API.dart';
import 'package:speakup/services/login.dart';
import 'package:speakup/model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _userController = TextEditingController();
final _passwordController = TextEditingController();


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
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

  saveDataUser(String code, String token, String email, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('code', code);
    await prefs.setString('token', token);
    await prefs.setString('email', email);
    await prefs.setString('name', name);

    print('token ' + token);

    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
      context, MaterialPageRoute(
      builder: (BuildContext context) => TimelinePage()));
  }

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
                      controller: _userController,
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
                        controller: _passwordController,
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
                    doCheckLogin();
                  }
                },
                child: Text('Login'))
          ],
        )
      )
    );
  }

  void doCheckLogin() {
    String username = _userController.text;
    String password = _passwordController.text;
    String fullUrl = API.BASE_URL + API.API_LOGIN;

    fetchPostLogin(http.Client(), username, password, fullUrl, context)
        .then((onValueLogin) {
      try{
        print(onValueLogin);
        // if (onValueLogin) {
        //   _passwordController.text = "";
        //   snackbarAlert("bisa login ");
        //   // saveDataUser(onValueLogin.data.fullname, onValueLogin.data.token, fullUrl,
        //   //     username, onValueLogin.data.acl, onValue.data.companyCode);
        // } else {
        //   Navigator.of(context).pop();
        //   snackbarAlert("Terjadi Kesalahan, " + onValueLogin.info);
        // }
      }catch(Exception){
        //Navigator.of(context).pop();
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }
}
