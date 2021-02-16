import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:speakup/services/API.dart';
import 'package:speakup/services/timeline.dart';
import 'package:http/http.dart' as http;

class ArticleComments {
  const ArticleComments({this.id, this.comment, this.fullName});

  final String id;
  final String comment;
  final String fullName;
}

class News {
  const News({this.id, this.liked, this.name, this.title, this.description, this.image});

  final String id;
  final bool liked;
  final String name;
  final String title;
  final String description;
  final List<String> image;

  @override
    String toString() {
      // TODO: implement toString
      var stringImage = StringBuffer();
      image.forEach((item){
        stringImage.write(item);
      });
      return "instance of title: ${title}, description: ${description}, image: ${stringImage}";
    }
}

const List<News> news = const <News>[
  
];

const List<ArticleComments> articletComments = const <ArticleComments>[
  
];

class NewsCard extends StatefulWidget {
  const NewsCard(
      {Key key,
      this.news,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final News news;
  final VoidCallback onTap;
  final News item;
  final bool selected;
  @override
  NewsCardList createState() {
    return NewsCardList();
  }
}

class NewsCardList extends State<NewsCard> {
  Color _loveButtonColor = Colors.black;
  bool liked;
  @override
  Widget build(BuildContext context) {
    setState(() {
      if (widget.item.liked == true) {
        liked = widget.item.liked;
        _loveButtonColor = Colors.red[700];
      }
    });
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (widget.selected) {
      textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Card(
        color: Colors.white,
        child: InkWell(
          onTap: widget.onTap,
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
                        widget.item.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.topLeft,
                child: CarouselSlider(
                  options: widget.item.image.length > 0 ? CarouselOptions(
                    aspectRatio: 16/9,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                  ) : CarouselOptions(
                    height: 0
                  ),
                  items: widget.item.image.map((i){
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
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: Colors.black
                    )
                  )
                ),
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.topLeft,
                child: Text(
                  widget.news.description,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                )
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: IconButton(
                        icon: Icon(Icons.favorite, color: _loveButtonColor),
                        onPressed: () {
                          print("love color "+_loveButtonColor.toString());
                          setState(() {
                            print("liked $liked");
                            _loveButtonColor = liked == true ? Colors.black : Colors.red[700];
                            liked = liked == true ? false : true;
                            doLikeArticle(widget.item.id);
                            print("favorite pressed "+widget.item.id);
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          print("comment pressed");
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        )
      );
  }

  void doLikeArticle(String articleId) {
      String baseUrl = API.BASE_URL;
      String likeArticleUrl = API.TIMELINE_LIKE;
      like(http.Client(), baseUrl+likeArticleUrl+"?article_id="+articleId.toString(), articleId, context)
      .then((onArticleLiked){
        try {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(liked == true ? onArticleLiked : "Post Unliked Successfully"),
          ));
          print("ini onLike $onArticleLiked");
        } catch (Exception) {

        }
      });
    }
}
