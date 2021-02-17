import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakup/model/news.dart';
import 'API.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<List<News>> fetchTimlineData(http.Client client, String baseUrl, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body;
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
        id: timeline["article_id"],
        liked: timeline["liked"] == "1" ? true : false,
        name: timeline["name"],
        title: timeline["content"],
        description: timeline["content"],
        image: images
      );
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

Future<String>submitPost(http.Client client, String baseUrl, List<Asset> images, String content, BuildContext context) async {
  try {
    print(baseUrl);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
      // "Authorization": "Bearer d221576c7e8493a5b53028918402e45ff97d1456"
    };

    Uri uri = Uri.parse(baseUrl);
    http.MultipartRequest request =  http.MultipartRequest("POST", uri);
    for (var image in images) {
      ByteData byteData = await image.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
        "medias[]",
        imageData,
        filename: image.name,
        contentType: MediaType("image", "jpeg")
      );
      request.files.add(multipartFile);
    }
    request.fields["content"] = content;
    request.fields["scope"] = "0";
    request.fields["status_id"] = "1";
    request.headers["Authorization"] = "Bearer "+prefs.getString('token');
    http.Response response = await http.Response.fromStream(await request.send());
    var data = json.decode(response.body);
    return data["info"];
  }on Exception catch(exception) {
      // Navigator.of(context).pop();
      return null;
    }catch(error){
      // Navigator.of(context).pop();
      return null;
    } 
}

Future<String>like(http.Client client, String baseUrl, String articleId, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
    };
    final response = await http.post(baseUrl+API.TIMELINE, headers: headers);
    var result = json.decode(response.body);
    return result["info"];
  }on Exception catch(exception) {
      // Navigator.of(context).pop();
      return null;
    }catch(error){
      // Navigator.of(context).pop();
      return null;
    } 
}

Future<List<ArticleComments>>getComments(http.Client client, String baseUrl, String articleId, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      "article_id": articleId,
    };
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
      // "Authorization": "Bearer d221576c7e8493a5b53028918402e45ff97d1456"
    };
    final response = await http.get(baseUrl+API.POST_COMMENT+"?article_id=$articleId", headers: headers);
    List<ArticleComments> articleComments = <ArticleComments>[];
    var commentsData = json.decode(response.body)["data"];
    for (var timeline in commentsData) {
      var newNews = ArticleComments(
        id: timeline["article_comment_id"],
        comment: timeline["comment"],
        fullName: timeline["full_name"],
      );
      articleComments.add(newNews);
    }

    return articleComments;
  } on Exception catch (exception) {
    return null;
  }catch(error){
    return null;
  }
}

Future<String>postComment(http.Client client, String baseUrl, String articleId, String comment, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> body = {
      "article_id": articleId,
      "comment": comment
    };
    Map<String, String> headers = {
      'Authorization': "Bearer "+prefs.getString('token')
      // "Authorization": "Bearer d221576c7e8493a5b53028918402e45ff97d1456"
    };

    final response = await http.post(baseUrl+API.POST_COMMENT, headers: headers, body: body);
    var result = json.decode(response.body);
    return result['info'];
  } on Exception catch (exception) {
    return null;
  }catch(error){
    return null;
  }
}