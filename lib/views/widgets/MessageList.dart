import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {

  MessageList({Key key}) : super(key: key);

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {

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
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.account_circle, size: 50.0),
                            title: Text('User Full Name'),
                            subtitle: Text('User message goes here'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('5 Minutes ago'),
                              )
                            ],
                          )
                        ]
                      ),
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