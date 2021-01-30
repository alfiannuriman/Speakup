import 'dart:convert';

import 'package:speakup/model/user.dart';
import 'package:speakup/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'API.dart';


Future<user> fetchPostUser(String full_name,  String telepon, String gender,String birth_place,String birth_date, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body;
    Map<String, dynamic> bodyAuth;
    Map<String, String> headers = {
      'Authorization': "Bearer "+ prefs.getString('token'),
    };

    bodyAuth = {
      'full_name':full_name,
      'telepon':telepon,
      'gender':gender,
      'birth_place':birth_place,
      'birth_date':birth_date
    };
    body = bodyAuth;

    print('body ' + body.toString());
    print('header ' + headers.toString());

    final response =
    await http.post(API.BASE_URL + API.API_GET_PROFILE, body: body, headers: headers);

    print('fetchPostUser '+response.body+API.BASE_URL + API.API_GET_PROFILE);

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

Future<user> fetchGetUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> body;
  Map<String, dynamic> bodyAuth;
  Map<String, String> headers = {
    'Authorization': "Bearer "+ prefs.getString('token'),
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
}

Future<List<Search>> fetchGetSearchUser(String keyword) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> body;
  Map<String, dynamic> bodyAuth;
  Map<String, String> headers = {
    'Authorization': "Bearer "+ prefs.getString('token'),
  };

  final response =
  await http.get(API.BASE_URL + API.API_SEARCH_PROFILE+"?full_name="+keyword, headers: headers);

  print('fetchGetSearchUser '+response.body+API.BASE_URL + API.API_SEARCH_PROFILE+"?full_name="+keyword);

  if(response.statusCode == 200){
    final list = json.decode(response.body);
    return list['data'];
  }else{
    return null;
  }
}


class Search {
  int user_id;
  String full_name;
  String avatar_filename;
  String avatar_file_url;

  Search({
    this.user_id,
    this.full_name,
    this.avatar_filename,
    this.avatar_file_url,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    user_id: json['user_id'],
    full_name: json['full_name'],
    avatar_filename: json['avatar_filename'],
    avatar_file_url: json['avatar_file_url'],
  );

  Map<String, dynamic> toJson() => {
    'user_id': user_id,
    'full_name': full_name,
    'avatar_filename': avatar_filename,
    'avatar_file_url': avatar_file_url,
  };
}

user parsePosts(String responseBody) {
  final parsed = json.decode(responseBody);
  var data = Map<String, dynamic>.from(parsed);
  user eventResponse = user.fromJson(data);
  return eventResponse;
}