import 'package:flutter/material.dart';

class PostList extends StatefulWidget {

  PostList({Key key}) : super(key: key);

  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostList> {

  final items = List<String>.generate(20, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: 480,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (BuildContext, index) {
                return Center(
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.account_circle),
                          title: Text('User Full Name'),
                          subtitle: Text('User post text goes here'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Icon(Icons.favorite_border),
                              onPressed: () { /* ... */ },
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Icon(Icons.chat),
                              onPressed: () { /* ... */ },
                            ),
                            const SizedBox(width: 8),
                          ],
                        )
                      ]
                    ),
                  )
                );
              },
            )
          ),
        )
      ]
    );
  }
}