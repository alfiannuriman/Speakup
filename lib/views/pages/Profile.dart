import 'package:flutter/material.dart';
import 'package:speakup/model/news.dart';
import 'package:speakup/views/news_detail.dart';
import 'package:speakup/views/widgets/CreatePost.dart';
import 'package:speakup/views/widgets/PostList.dart';
import 'package:speakup/views/widgets/MessageList.dart';

const Color shrinePink50 = Color(0xFFE1F5FE);
const Color shrinePink100 = Color(0xFFB3E5FC);
const Color shrinePink300 = Color(0xFF81D4FA);
const Color shrinePink400 = Color(0xFF29B6F6);

const Color shrineBrown900 = Color(0xFF00B8D4);
const Color shrineBrown600 = Color(0xFF00E5FF);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;

class TimelinePage extends StatefulWidget {
  @override
  TimelinePageState createState() {
    return TimelinePageState();
  }
}

class TimelinePageState extends State<TimelinePage> {
int _currentIndex = 0;
  String pageTitle = "Beranda";

  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final _listPage = <Widget>[
      ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return NewsCard(
            news: news[index],
            item: news[index],
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsDetail(news: news[index]))
              );
            },
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        centerTitle: true,
      ),
      body: Center(
        child: _listPage[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: colorScheme.onSurface.withOpacity(.60),
        unselectedLabelStyle: textTheme.caption,
        selectedLabelStyle: textTheme.caption,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            switch (value) {
              case 1:
                pageTitle = "Pencairan";  
                break;
              case 2:
                pageTitle = "Profile";
                break;
              default:
              pageTitle = "Trending";
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Trending'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('Cari'),
            icon: Icon(Icons.search),
          ),
          // BottomNavigationBarItem(
          //   title: Text('Notifikasi'),
          //   icon: Icon(Icons.notifications),
          // ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
