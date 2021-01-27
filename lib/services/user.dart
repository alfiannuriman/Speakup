import 'dart:convert';

import 'package:speakup/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'API.dart';


Future<user> fetchGetUser(http.Client client, String token, BuildContext context) async {
  try {
    print(token);
    Map<String, dynamic> body;
    Map<String, dynamic> bodyAuth;
    Map<String, String> headers = {
      'Authorization': "Bearer "+ token,
    };

    print(headers);
    print('body ' + body.toString());
    final response =
    await http.get(API.BASE_URL + API.API_GET_PROFILE, headers: headers);

    print('fetchGetUser '+response.body+API.BASE_URL + API.API_GET_PROFILE);

    if(response.statusCode == 200){
      return compute(parsePosts, response.body);
    }else{
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

user parsePosts(String responseBody) {
  final parsed = json.decode(responseBody);
  var data = Map<String, dynamic>.from(parsed);
  user eventResponse = user.fromJson(data);
  return eventResponse;
}