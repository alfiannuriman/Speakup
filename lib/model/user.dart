import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:speakup/model/news.dart';

class user {
  int code;
  String info;
  String token;
  Data data;

  user({this.code, this.info, this.data});

  user.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    info = json['info'];
    info = json['token'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['info'] = this.info;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
class Data {

  String full_name;
  String detail_id;
  String user_id;
  String telepon;
  String birth_date;
  String birth_place;
  String gender;
  String followers;
  String following;
  bool is_followed;
  List<News> posts;


  Data({this.full_name, this.detail_id, this.user_id, this.telepon, this.birth_date, this.birth_place, this.gender, this.followers, this.following, this.is_followed, this.posts});

  Data.fromJson(Map<String, dynamic> json) {
    full_name = json['full_name'];
    detail_id = json['detail_id'];
    user_id = json['user_id'];
    telepon = json['telepon'];
    birth_date = json['birth_date'];
    birth_place = json['birth_place'];
    gender = json['gender'];
    following = json['following'];
    followers = json['followers'];
    is_followed = json['is_followed'];
    var timelinesData = json['posts'];
    List<News> timelinesList = <News>[];
    for (var timeline in timelinesData) {
      List<String> images = [];
      for (var image in timeline["medias"] ?? []) {
        images.add(image["file_url"]);
      }
      var newNews = News(
          id: timeline["article_id"],
          liked: timeline["liked"] == "1" ? true : false,
          name: json["full_name"],
          title: timeline["content"],
          description: timeline["content"],
          image: images
      );
      timelinesList.add(newNews);
    }
    posts = timelinesList;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.full_name;
    data['detail_id'] = this.detail_id;
    data['user_id'] = this.user_id;
    data['telepon'] = this.telepon;
    data['birth_place'] = this.birth_place;
    data['birth_date'] = this.birth_date;
    data['gender'] = this.gender;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['is_followed'] = this.is_followed;
    data['posts'] = this.posts;
    return data;
  }
}
