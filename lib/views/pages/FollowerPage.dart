import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:speakup/views/pages/ProfileDetailPage.dart';
import 'package:speakup/services/API.dart';
import 'package:speakup/services/listuser.dart';
import 'package:speakup/model/listuser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speakup/model/user.dart';

class FollowerPage extends StatefulWidget {
  final String title;
  final String user_id;

  FollowerPage({
    Key key,
    this.title,
    this.user_id
  }): super(key: key);

  @override
  _FollowerPageState createState() => _FollowerPageState();
}

class _FollowerPageState extends State<FollowerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<ListUser>>(
          future: fetchGetFollowerUser(widget.title, widget.user_id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return UserCard(
                    listuser: snapshot.data[index],
                    item: snapshot.data[index],
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProfileDetail(profile: snapshot.data[index]))
                      );
                    },
                  );
                  // return ListTile(
                  //   title: Text(snapshot.data[index].full_name),
                  //   onTap: () {
                  //     close(context, snapshot.data[index]);
                  //   },
                  // );
                },
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ToDoSearchDelegate extends SearchDelegate<ListUser> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      Center(
        child: CircularProgressIndicator(),
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ListUser>>(
      future: fetchGetSearchUser(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return UserCard(
                listuser: snapshot.data[index],
                item: snapshot.data[index],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileDetail(profile: snapshot.data[index]))
                  );
                },
              );
              // return ListTile(
              //   title: Text(snapshot.data[index].full_name),
              //   onTap: () {
              //     close(context, snapshot.data[index]);
              //   },
              // );
            },
            itemCount: snapshot.data.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
