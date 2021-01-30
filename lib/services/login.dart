import 'dart:convert';

import 'package:speakup/model/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'API.dart';


Future<Login> fetchPostLogin(http.Client client, String username, String password, String baseUrl, BuildContext context) async {
  try {
    Map<String, dynamic> body;
    Map<String, dynamic> bodyAuth;

    bodyAuth = {'username': username, 'password': password};
    body = bodyAuth;

    print('body ' + body.toString());
    final response =
    await http.post(baseUrl + API.API_LOGIN, body: body);

    print('fetchPostLogin '+response.body+baseUrl + API.API_LOGIN);
    
    if(response.statusCode == 200){
      return compute(parsePosts, response.body);
    }else{
      Navigator.of(context).pop();
      return null;
    }
  } on Exception catch (exception) {
    Navigator.of(context).pop();
    return null;
  } catch (error) {
    Navigator.of(context).pop();
    print(error);
    return null;
  }
}

Future<Login> fetchGetLogin(http.Client client, String token, BuildContext context) async {
  try {
    Map<String, dynamic> body;
    Map<String, dynamic> bodyAuth;
    Map<String, String> headers = {
      'Authorization': "Bearer "+ token,
    };

    bodyAuth = {};
    body = bodyAuth;
    final response =
    await http.get(API.BASE_URL + API.API_GET_USER, headers: headers);

    print('fetchGetLogin '+response.body+API.BASE_URL + API.API_GET_USER);

    if(response.statusCode == 200){
      return compute(parsePosts, response.body);
    }else{
      return compute(parsePosts, response.body);
    }
  } on Exception catch (exception) {
    Navigator.of(context).pop();
    return null;
  } catch (error) {
    Navigator.of(context).pop();
    print(error);
    return null;
  }
}

Login parsePosts(String responseBody) {
  final parsed = json.decode(responseBody);
  var data = Map<String, dynamic>.from(parsed);
  Login eventResponse = Login.fromJson(data);
  return eventResponse;
}