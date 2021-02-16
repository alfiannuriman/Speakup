import 'package:flutter/material.dart';
import 'package:speakup/views/pages/RegisterPage.dart';
import 'package:speakup/views/pages/AboutPage.dart';
import 'package:speakup/views/pages/BasePage.dart';

import 'package:speakup/components/scroll.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:speakup/services/API.dart';
import 'package:speakup/services/login.dart';
import 'package:speakup/model/Login.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakup/tools/extension.dart';

final _userController = TextEditingController();
final _passwordController = TextEditingController();

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
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
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => BasePage()));
  }

  loadDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String token = prefs.getString('token');
      print(token);
      if (token != '' && token != null) {
        doCheckLogin(token);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover)),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                title: Text('SpeakUp - Share Stories From Around The World')),
            body: SingleChildScrollView(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 40.0),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/logo-primary-croped.PNG'),
                                      fit: BoxFit.cover)),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: SizedBox(
                            width: double.infinity,
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
                                      icon: Icon(Icons.people),
                                      labelText: 'Username',
                                      hintText: 'Masukan Username',
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
                                      obscureText: true,
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
                        ),
                      ])),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          child: Text('Login'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Dialogs.showLoadingDialog(
                                context, _scaffoldKey
                              );
                              doLogin();
                            }
                          }),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                          textColor: Theme.of(context).cursorColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text(
                            "Belum punya akun ? klik disini.",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.right,
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        color: Colors.green,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()));
                        },
                        child: Text(
                          "About Us",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  )
                ],
              )),
            )));
  }

  void doLogin() {
    String username = _userController.text;
    String password = _passwordController.text;
    String baseUrl = API.BASE_URL;

    fetchPostLogin(http.Client(), username, password, baseUrl, context)
        .then((onValueLogin) {
      try {
        print(onValueLogin);
        if (onValueLogin.data != null) {
          Navigator.of(_scaffoldKey.currentContext, rootNavigator: true).pop();
          _passwordController.text = "";
          saveDataUser(onValueLogin.data.code, onValueLogin.data.token,
              onValueLogin.data.email, onValueLogin.data.name);
        } else {
          Navigator.of(context).pop();
          snackbarAlert("Terjadi Kesalahan");
        }
      } catch (Exception) {
        //Navigator.of(context).pop();
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }

  void doCheckLogin(String token) {
    fetchGetLogin(http.Client(), token, context).then((response) {
      try {
        print(response);
        if (response.code == 200) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BasePage()));
        } else {
          // snackbarAlert("Terjadi Kesalahan");
        }
      } catch (Exception) {
        //Navigator.of(context).pop();
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }
}
