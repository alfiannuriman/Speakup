import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:speakup/views/pages/HomePage.dart';

class Preferences
{
  clearPreferences(BuildContext context) async {
    String email = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    email = preferences.getString('email');
    preferences.clear();
    print('email '+email);
    await preferences.setBool('firstRun', true);
    await preferences.setString('email', email);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomePage()));
  }
}