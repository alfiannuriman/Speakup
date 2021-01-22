import 'dart:convert';

import 'package:speakup/model/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'API.dart';


Future<Register> fetchPostRegister(http.Client client, String email,  String username, String password, BuildContext context) async {
  try {
    Map<String, dynamic> body;
    Map<String, dynamic> bodyAuth;

    bodyAuth = {'email': email, 'username': username, 'password': password};
    body = bodyAuth;

    print('body ' + body.toString());

    final response =
    await http.post(API.BASE_URL + API.API_REGISTER, body: body);

    print('fetchPostLogin '+response.body+API.BASE_URL + API.API_REGISTER);

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
    return null;
  }
}

Register parsePosts(String responseBody) {
  final parsed = json.decode(responseBody);
  var data = Map<String, dynamic>.from(parsed);
  Register eventResponse = Register.fromJson(data);
  return eventResponse;
}
