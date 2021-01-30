import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:speakup/services/API.dart';
import 'package:speakup/services/timeline.dart';
import 'package:speakup/views/widgets/CreatePost.dart';
import 'package:http/http.dart' as http;

final _captionTextController = TextEditingController();

class CreatePost extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return CreatePostPage();
    }
}

class CreatePostPage extends StatefulWidget {
  CreatePostPage({Key key, this.title}) : super(key: key);
  final String title;

  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var _isVisible = false;
  List<Asset> images = List<Asset>();
  String _error = "No error detected";
  String pageTitle = "Tambah Post";
  @override
  void initState() {
    super.initState();
  }

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

  Widget buildGridView() {
    var length = images.length > 0;;
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index){
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _isVisible = !images.isEmpty;
      _error = error;
    });
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(pageTitle),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              doSubmitPost();
            }
            // Respond to button press
          },
          icon: Icon(Icons.add),
          label: Text('Buat Post'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                  controller: _captionTextController,
                  maxLines: null,
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: InputDecoration(
                    icon: Icon(Icons.perm_identity), labelText: "Caption"),
                ),
              ),
            ),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            ),
          ],
        ),
      );
    }

    void doSubmitPost() {
      String caption = _captionTextController.text;
      String baseUrl = API.BASE_URL;
      String timelineUrl = API.TIMELINE;
      submitPost(http.Client(), baseUrl+timelineUrl, images, caption, context)
      .then((onPostSubmitted){
        try {
          _captionTextController.text = "";
          snackbarAlert(onPostSubmitted);
        } catch (Exception) {
          snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
        }
      });
    }
}