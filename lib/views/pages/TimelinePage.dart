import 'package:flutter/material.dart';
import 'package:speakup/model/news.dart';
import 'package:speakup/services/API.dart';
import 'package:speakup/services/timeline.dart';
import 'package:speakup/views/news_detail.dart';
import 'package:speakup/views/pages/ProfilePage.dart';
import 'package:speakup/views/pages/CreatePostPage.dart';

import 'package:speakup/views/widgets/CreatePost.dart';
import 'package:speakup/views/widgets/PostList.dart';
import 'package:speakup/views/widgets/MessageList.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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


class TimelinePageState extends State<TimelinePage> with WidgetsBindingObserver {
int _currentIndex = 0;
  String pageTitle = "Beranda";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var timelines = news;

  snackbarAlert(String alertText) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: Colors.red,
              size: 16,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            width: MediaQuery.of(context).size.width / 1.5,
            child: Text(
              alertText,
              style: TextStyle(fontSize: 14.0),
            ),
          )
        ],
      ),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: timelines.length,
          itemBuilder: (context, index) {
            return NewsCard(
              news: timelines[index],
              item: timelines[index],
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewsDetail(news: timelines[index]))
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreatePostPage())
          );
          // Respond to button press
        },
        icon: Icon(Icons.add),
        label: Text('Buat Post'),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    loadTimeLineData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
    loadTimeLineData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    loadTimeLineData();
  }

  void loadTimeLineData() {
    String baseUrl = API.BASE_URL;
    fetchTimlineData(http.Client(), baseUrl, context).then((onvalueTimline) {
      try {
        if (this.mounted) {
          setState(() {
            timelines = onvalueTimline;
          });
        }
      } catch (Exception) {
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }
}
