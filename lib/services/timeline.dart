import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakup/model/news.dart';
import 'API.dart';
import 'package:http/http.dart' as http;

Future<List<News>> fetchTimlineData(http.Client client, String baseUrl, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body;
    print(prefs.getString('token'));
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
      // "Authorization": "Bearer d221576c7e8493a5b53028918402e45ff97d1456"
    };

    final response = await http.get(baseUrl+API.TIMELINE, headers: headers);

    List<News> timelinesList = <News>[];
    var timelinesData = json.decode(response.body)["data"];
    for (var timeline in timelinesData) {
      List<String> images = [];
      for (var image in timeline["medias"] ?? []) {
        images.add(image["file_url"]);
      }
      var newNews = News(
        name: timeline["name"],
        title: timeline["content"],
        description: timeline["content"],
        image: images
      );
      print(newNews);
      timelinesList.add(newNews);
    }
    // print("zxc");
    // print(timelinesList);
    return timelinesList;
    // print(json.decode(response.body)["data"]);
  }on Exception catch(exception) {
    // Navigator.of(context).pop();
    return null;
  }catch(error){
    // Navigator.of(context).pop();
    return null;
  }
}