import 'package:flutter/material.dart';
import 'package:speakup/views/widgets/CreatePost.dart';
import 'package:speakup/views/widgets/PostList.dart';

class TimelinePage extends StatefulWidget {
  @override
  TimelinePageState createState() {
    return TimelinePageState();
  }
}

class TimelinePageState extends State<TimelinePage> {

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    new CreatePost(),
    new PostList(),
    Text(
      'Index 2: Messages',
      style: optionStyle,
    ),
  ];

  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Timeline Page')),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Center(
                  // child: _widgetOptions.elementAt(_selectedIndex),
                  child: _widgetOptions[_selectedIndex]
                ),
              ],
            )),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.post_add),
                label: 'Post'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                label: 'Timeline'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Messages'
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onNavigationItemTapped,
          )  
        );
  }
}
