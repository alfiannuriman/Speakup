import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:speakup/model/news.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:speakup/services/API.dart';
import 'package:speakup/services/timeline.dart';
import 'package:http/http.dart' as http;
import 'package:speakup/tools/extension.dart';

final _commentTextController = TextEditingController();

class NewsDetail extends StatelessWidget {
  final News news;
  final bool isComment;

  NewsDetail({
    Key key, @required this.news, this.isComment
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NewsDetailPage(
      key: key,
      title: news.title,
      news: news,
      isComment: isComment,
    );
  }
}

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage({
    Key key,
    this.title,
    this.news,
    this.isComment
  });
  final News news;
  final String title;
  final bool isComment;
  _NewsDetailState createState() => _NewsDetailState(id: news.id,image: news.image, title: news.title, description: news.description, isComment: isComment);
}

class _NewsDetailState extends State<NewsDetailPage>  with WidgetsBindingObserver  {
  final GlobalKey<State> _scaffoldKey = new GlobalKey<State>();
  final String id;
  final String title;
  final List<String> image;
  final String description;
  final bool isComment;
  var comments = articletComments;
  _NewsDetailState({
    this.id,
    this.title,
    this.image,
    this.description,
    this.isComment
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // print("ini isComment $isComment");
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        )
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.topLeft,
                child: CarouselSlider(
                  options: image.length > 0 ? CarouselOptions(
                    aspectRatio: 16/9,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                  ) : CarouselOptions(
                    height: 0
                  ),
                  items: image.map((i){
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber
                          ),
                          child: FittedBox(
                            child: Image.network(i),
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                alignment: Alignment.topLeft,
                child: Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                    child: TextField(
                      autofocus: isComment,
                      controller: _commentTextController,
                      cursorColor: Theme.of(context).cursorColor,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            // Dialogs.showLoadingDialog(context, _scaffoldKey);
                            doCommentArticle(id, context);
                          },
                        ),
                        icon: Icon(Icons.post_add), labelText: "Komentar"),
                      ),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                alignment: Alignment.topLeft,
                child: Text(
                  "Komentar",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 25, 10, 25),
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black
                          )
                        )
                      ),
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: [
                          Text(
                            comments[index].fullName+": ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            comments[index].comment,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    );
                  },
                )
              )
            ],
          )
        ),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    doLoadPostComment(id, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
    doLoadPostComment(id, context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    doLoadPostComment(id, context);
  }

  void doLoadPostComment(String articleId, BuildContext context) {
    String baseUrl = API.BASE_URL;
    getComments(http.Client(), baseUrl, articleId, context)
    .then((onArticleComments){
      try {
        print("response $onArticleComments");
        if (this.mounted) {
          setState(() {
            comments = onArticleComments;
          });
        }
      } on Exception catch (exception) {
        print(exception);
      }
    });
  }
  
  void doCommentArticle(String articleId, BuildContext context) {
    String comment = _commentTextController.text;
    String baseUrl = API.BASE_URL;
    postComment(http.Client(), baseUrl, articleId, comment, context)
    .then((onArticleCommented){
      try {
        print("response $onArticleCommented");
        // Navigator.of(context, rootNavigator: true).pop();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("$onArticleCommented"),
        ));
        doLoadPostComment(articleId, context);
      } on Exception catch (exception) {
        print(exception);
      }
    });
  }
}