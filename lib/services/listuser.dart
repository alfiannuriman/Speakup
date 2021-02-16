import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakup/model/listuser.dart';
import 'API.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<List<ListUser>> fetchGetSearchUser(String keyword) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body;
    print(prefs.getString('token'));
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
    };

    final response = await http.get(API.BASE_URL + API.API_SEARCH_PROFILE+"?full_name="+keyword, headers: headers);

    List<ListUser> userList = <ListUser>[];
    var timelinesData = json.decode(response.body)["data"];
    for (var timeline in timelinesData) {
      var newNews = ListUser(
          user_id: timeline["user_id"],
          full_name: timeline["full_name"],
          avatar_filename: timeline["avatar_filename"],
          avatar_file_url: timeline["avatar_file_url"]
      );
      userList.add(newNews);
    }

    return userList;
  }on Exception catch(exception) {
    // Navigator.of(context).pop();
    return null;
  }catch(error){
    // Navigator.of(context).pop();
    return null;
  }
}

Future<List<ListUser>> fetchGetFollowerUser(String title, String user_id) async {

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body;
    print(prefs.getString('token'));
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
    };

    String url  = API.BASE_URL + API.API_FOLLOWER+"?user_id="+user_id;
    if(title == "Following"){
      url  = API.BASE_URL + API.API_FOLLOWING+"?user_id="+user_id;
    }


    final response = await http.get(url, headers: headers);
    List<ListUser> userList = <ListUser>[];
    var timelinesData = json.decode(response.body)["data"];
    for (var timeline in timelinesData) {
      var newNews = ListUser(
          user_id: timeline["user_id"],
          full_name: timeline["full_name"],
          avatar_filename: timeline["avatar_filename"],
          avatar_file_url: timeline["avatar_file_url"]
      );
      userList.add(newNews);
    }

    return userList;
  }on Exception catch(exception) {
    // Navigator.of(context).pop();
    return null;
  }catch(error){
    // Navigator.of(context).pop();
    return null;
  }
}