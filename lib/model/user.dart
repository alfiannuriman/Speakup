import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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


  Data({this.full_name, this.detail_id, this.user_id, this.telepon, this.birth_date, this.birth_place, this.gender, this.followers, this.following});

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
    return data;
  }
}


class ListUser extends StatelessWidget {
  const ListUser(
      {Key key,
        this.data,
        this.onTap,
        @required this.item,
        this.selected: false})
      : super(key: key);

  final Data data;
  final VoidCallback onTap;
  final Data item;
  final bool selected;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected) {
      textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Card(
        color: Colors.white,
        child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1.0,
                              color: Colors.black
                          )
                      )
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage("https://adminlte.io/themes/AdminLTE/dist/img/user2-160x160.jpg"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text(
                          item.full_name,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}