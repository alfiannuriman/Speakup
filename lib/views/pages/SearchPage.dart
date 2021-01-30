import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:speakup/views/pages/TimelinePage.dart';
import 'package:speakup/services/API.dart';
import 'package:speakup/services/listuser.dart';
import 'package:speakup/model/listuser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final toDo = await showSearch<ListUser>(
                  context: context,
                  delegate: ToDoSearchDelegate(),
                );
              },
          )
        ],
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
          print(snapshot.data);
          return ListView.builder(
            itemBuilder: (context, index) {
              return UserCard(
                listuser: snapshot.data[index],
                item: snapshot.data[index],
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => UserDetail(news: snapshot.data[index]))
                  // );
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
