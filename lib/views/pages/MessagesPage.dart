import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  @override
  MessagesPageState createState() {
    return MessagesPageState();
  }
}

class MessagesPageState extends State<MessagesPage> {
  var chatMessages = List<ChatData>();
  int _viewTypeMessage = -1;
  var _messageTextEditingController = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var chatMessage = chatMessages[index];
                      switch (chatMessage._viewType) {
                        case 1:
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                color: Colors.orange,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    chatMessage._message,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        default:
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(chatMessage._message),
                                ),
                              ),
                            ],
                          );
                      }
                    },
                    itemCount: chatMessages.length,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: _viewTypeMessage,
                            onChanged: (value) {
                              setState(() {
                                _viewTypeMessage = value;
                              });
                            },
                          ),
                          Text("Left"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Radio(
                            value: 2,
                            groupValue: _viewTypeMessage,
                            onChanged: (value) {
                              setState(() {
                                _viewTypeMessage = value;
                              });
                            },
                          ),
                          Text("Right"),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _messageTextEditingController,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        var message = _messageTextEditingController.text.trim();
                        if (message.isEmpty) {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Message is empty"),
                            ),
                          );
                        } else if (_viewTypeMessage == -1) {
                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                "Please choose view type message",
                              ),
                            ),
                          );
                        } else {
                          setState(() {
                            _messageTextEditingController.clear();
                            chatMessages
                                .add(ChatData(message, _viewTypeMessage));
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatData {
  String _message;
  int _viewType;

  ChatData(this._message, this._viewType);

  int get viewType => _viewType;

  set viewType(int value) {
    _viewType = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }
}