import 'dart:convert';

import 'package:speakup/model/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'API.dart';


Future<Login> fetchPostLogin(http.Client client, String username, String password, String baseUrl, bool remember, String tokenFcm, BuildContext context) async {
  try {
    Map<String, dynamic> body;
    Map<String, dynamic> bodyAuth;

    bodyAuth = {'code': username, 'password': password, 'remember': remember, 'fcm_token': tokenFcm};
    body = {'data': jsonEncode(bodyAuth)};

    print('body ' + body.toString());

    final response =
    await http.post(baseUrl + API.API_LOGIN, body: body, headers: headers);

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
    return null;
  }
}

Login parsePosts(String responseBody) {
  final parsed = json.decode(responseBody);
  var data = Map<String, dynamic>.from(parsed);
  Login eventResponse = Login.fromJson(data);
  return eventResponse;
}
