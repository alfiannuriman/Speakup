import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ListUser {
  const ListUser({this.user_id, this.full_name, this.avatar_filename, this.avatar_file_url});

  final String user_id;
  final String full_name;
  final String avatar_filename;
  final String avatar_file_url;
}

const List<ListUser> listuser = const <ListUser>[

];

class UserCard extends StatelessWidget {
  const UserCard(
      {Key key,
        this.listuser,
        this.onTap,
        @required this.item,
        this.selected: false})
      : super(key: key);

  final ListUser listuser;
  final VoidCallback onTap;
  final ListUser item;
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
