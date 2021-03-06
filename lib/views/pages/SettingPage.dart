import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:speakup/services/user.dart';
import 'package:speakup/services/preferences.dart';

import 'package:speakup/model/news.dart';
import 'package:speakup/model/user.dart';


import 'package:speakup/views/pages/HomePage.dart';
import 'package:speakup/views/pages/AboutPage.dart';
import 'package:speakup/views/pages/FollowerPage.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SettingPage();
  }
}

class SettingPage extends StatefulWidget {
  SettingPage({Key key, this.title}) : super(key: key);

  final String title;
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<String> _calculation = Future<String>.delayed(
    Duration(seconds: 2),
        () => 'Data Loaded',
  );

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

  void doPostUser() {
    String full_name = _fullnameController.text;
    String telepon = _teleponController.text;
    String birth_place = _birthplaceController.text;
    String birth_date = _birthdateController.text;
    String gender = _valGender;
    fetchPostUser(full_name, telepon, gender, birth_place, birth_date, context)
        .then((onValueLogin) {
      try {
        if (onValueLogin.code == 200) {
          // Navigator.of(context).pop();
          snackbarAlert("Update Berhasil");
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
        future: fetchGetUser(), // a previously-obtained Future<String> or null
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
                          Center(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: code,
                                cursorColor: Theme.of(context).cursorColor,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.perm_identity), labelText: "Nama Pengguna"),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: email,
                                cursorColor: Theme.of(context).cursorColor,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.email), labelText: "E-mail"),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: TextFormField(
                                controller: _fullnameController,
                                cursorColor: Theme.of(context).cursorColor,

                                decoration: InputDecoration(
                                    icon: Icon(Icons.perm_identity), labelText: "Nama Lengkap"),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: TextFormField(
                                controller: _teleponController,
                                cursorColor: Theme.of(context).cursorColor,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone), labelText: "Telepon"),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: TextFormField(
                                controller: _birthplaceController,
                                cursorColor: Theme.of(context).cursorColor,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.place), labelText: "Tempat Lahir"),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                              child: TextFormField(
                                readOnly: true,
                                controller: _birthdateController,
                                cursorColor: Theme.of(context).cursorColor,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.date_range), labelText: "Tanggal Lahir"),
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true, onChanged: (date) {

                                      }, onConfirm: (date) {

                                        String date1 = date.toString().split(' ')[0];
                                        String date2 = date.toString().split(' ')[1];
                                        String time =
                                            date2.split(':')[0] + ':' + date2.split(':')[1];
                                        _birthdateController.text = date1;
                                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                                },
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: DropdownButton(
                              hint: Text("Select The Gender"),
                              value: _valGender,
                              isExpanded: true,
                              // style: TextStyle(color: Colors.white),
                              items: _listGender.map((value) {
                                return DropdownMenuItem(
                                  child:Row(
                                    children: <Widget>[
                                      Icon(Icons.perm_identity),
                                      SizedBox(width: 10),
                                      Text(
                                        value == "M"
                                            ? "Pria"
                                            : "Wanita",
                                      ),
                                    ],
                                  ),
                                  // child: Text(value == "M"
                                  //     ? "Pria"
                                  //     : "Wanita"),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _valGender = value;  //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                                });
                              },
                            ),
                          )
                        ]
                    )
                ),
                Center(
                  child: Container(
                    child: FlatButton.icon(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          this.doPostUser();
                        }
                      },
                      icon: Icon(Icons.save),
                      label: Text("Simpan"),
                      textColor: Colors.white,
                      color: Theme.of(context).cursorColor,
                      minWidth: 350,
                    ),
                  ),
                ),
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
              title: Text("Setting"),
              centerTitle: true,
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
