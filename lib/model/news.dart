import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class News {
  const News({this.name, this.title, this.description, this.image});

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

class NewsCard extends StatelessWidget {
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
                        item.name,
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
                  options: item.image.length > 0 ? CarouselOptions(
                    aspectRatio: 16/9,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                  ) : CarouselOptions(
                    height: 0
                  ),
                  items: item.image.map((i){
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
                  news.description,
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
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      child: IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          
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
}
