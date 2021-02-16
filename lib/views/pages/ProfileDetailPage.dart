import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:speakup/services/user.dart';
import 'package:speakup/services/preferences.dart';

import 'package:speakup/model/listuser.dart';
import 'package:speakup/model/user.dart';
import 'package:speakup/model/news.dart';

import 'package:speakup/views/pages/HomePage.dart';
import 'package:speakup/views/news_detail.dart';
import 'package:speakup/views/pages/FollowerPage.dart';


class ProfileDetail extends StatelessWidget {

  final ListUser profile;

  ProfileDetail({
    Key key, @required this.profile
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProfileDetailPage(
      key: key,
      full_name: profile.full_name,
      profile: profile,
    );
  }
}

class ProfileDetailPage extends StatefulWidget {

  final ListUser profile;
  final String full_name;

  ProfileDetailPage({
    Key key,
    this.full_name,
    this.profile
  }): super(key: key);

  _ProfileDetailPageState createState() => _ProfileDetailPageState(full_name: profile.full_name, profile : profile);
}

class _ProfileDetailPageState extends State<ProfileDetailPage> {
  final String full_name;
  final ListUser profile;

  _ProfileDetailPageState({
    this.full_name,
    this.profile
  });

  String name = '';
  String code = '';
  String email = '';
  String token = '';
  int follower = 0;
  Data dataUser;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _fullnameController = TextEditingController();
  final _teleponController = TextEditingController();
  final _birthplaceController = TextEditingController();
  final _birthdateController = TextEditingController();

  Data asyncWidget = null;
  String _valGender = "M";
  List _listGender = ["M", "F"];

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

  loadDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      name = prefs.getString('name');
      code = prefs.getString('code');
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    super.initState();
    loadDataUser();
  }

  void doFollow(String user_id) {
    fetchPostFollow(user_id)
        .then((onValueLogin) {
      try {
        if (onValueLogin.code == 200) {
          Navigator.of(context).pop();
          snackbarAlert("Berhasil Mengikuti");
        } else {
          snackbarAlert("Terjadi Kesalahan");
        }
      } catch (Exception) {
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }

  void doUnfollow(String user_id) {
    fetchPostUnfollow(user_id)
        .then((onValueLogin) {
      try {
        if (onValueLogin.code == 200) {
          Navigator.of(context).pop();
          snackbarAlert("Berhenti Mengikuti");
        } else {
          // Navigator.of(context).pop();
          snackbarAlert("Terjadi Kesalahan");
        }
      } catch (Exception) {
        // Navigator.of(context).pop();
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2,
      textAlign: TextAlign.center,
      child: FutureBuilder<user>(
        future: fetchGetUser(profile.user_id), // a previously-obtained Future<String> or null
        builder: (context, snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data.code == 200) {
              dataUser = snapshot.data.data;
              _valGender = (dataUser.gender == null || dataUser.gender == '') ? "M" : dataUser.gender;
              _fullnameController.text = dataUser.full_name == null ? "" : dataUser.full_name;
              _teleponController.text = dataUser.telepon == null ? "" : dataUser.telepon;
              _birthplaceController.text = dataUser.birth_place == null ? "" : dataUser.birth_place;
              _birthdateController.text = dataUser.birth_date == null ? null : dataUser.birth_date;

              children = <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10 ,0, 30),
                            color: Color(0xFFEFEFEF),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: new BoxDecoration(
                                          border: Border.all(
                                              width: 3.0,
                                              color: const Color(0xFFFFFFFF)),
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  "https://adminlte.io/themes/AdminLTE/dist/img/user2-160x160.jpg"
                                              )
                                          )
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text(
                                      dataUser.full_name == null
                                          ? "Tidak ada nama"
                                          : dataUser.full_name,
                                      style: TextStyle(
                                        color: Color(0xFF343434),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Center(
                                        child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(20, 0 ,20, 0),
                                                    child: InkWell(
                                                      child: Text(
                                                        "Follower : "+ dataUser.followers,
                                                        style: TextStyle(
                                                          color: Color(0xFF666666),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(builder: (context) => FollowerPage(title: "Follower", user_id: dataUser.user_id ))
                                                        );
                                                      },
                                                    )
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(20, 0 ,20, 0),
                                                    child: InkWell(
                                                      child: Text(
                                                        "Following : "+ dataUser.following,
                                                        style: TextStyle(
                                                          color: Color(0xFF666666),
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(builder: (context) => FollowerPage(title: "Following", user_id: dataUser.user_id ))
                                                        );
                                                      },
                                                    )
                                                  ),
                                                ],
                                              ),
                                            ]
                                        ),
                                      )
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: FlatButton(
                                      onPressed: () {
                                        if(dataUser.is_followed){
                                          this.doUnfollow(profile.user_id);
                                        }else{
                                          this.doFollow(profile.user_id);
                                        }

                                      },
                                      child: Text((dataUser.is_followed)? "Unfollow" : "Follow"),
                                      textColor: Colors.white,
                                      color: Theme.of(context).cursorColor,
                                      minWidth: 350,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: dataUser.posts.length,
                              itemBuilder: (context, index) {
                                return NewsCardProfile(
                                  news: dataUser.posts[index],
                                  item: dataUser.posts[index],
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => NewsDetail(news: dataUser.posts[index]))
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ]
                    )
                )
              ];

            }else{
              Navigator.pushReplacement(
                  context, MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
              Preferences().clearPreferences(context);
            }

          } else if (snapshot.hasError) {
            children = <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ],
                ),
              )
            ];
          } else {
            children = <Widget>[
              Center(
                child: CircularProgressIndicator(),
              ),
            ];
          }
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(full_name),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0 ,0, 25),
                child: Column(
                    children: children
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
