import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakup/model/news.dart';
import 'API.dart';
import 'package:http/http.dart' as http;

Future<News> fetchTimlineData(http.Client client, String baseUrl, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body;
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
    };

    final response = await http.get(baseUrl+API.TIMELINE, headers: headers);

    print("response "+response.body);
  }on Exception catch(exception) {
    Navigator.of(context).pop();
    return null;
  }catch(error){
    Navigator.of(context).pop();
    return null;
  }
}