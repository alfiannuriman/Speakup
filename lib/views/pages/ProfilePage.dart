import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:speakup/services/user.dart';
import 'package:speakup/services/preferences.dart';

import 'package:speakup/model/user.dart';
import 'package:speakup/views/pages/HomePage.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ProfilePage();
  }
}


class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String code = '';
  String email = '';
  String token = '';
  int follower = 0;
  Data dataUser;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final inputController = TextEditingController();

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
    fetchGetUser(http.Client(), token, context)
        .then((response) {
      try{
        if (response.code == 200) {
          dataUser = response.data;
        } else {
          // Navigator.of(context).pop();
          snackbarAlert("Terjadi Kesalahan");
        }
      }catch(Exception){
        //Navigator.of(context).pop();
        snackbarAlert("Terjadi Kesalahan, silakan coba beberapa saat lagi");
      }
    });
  }
  @override
  void initState() {
    loadDataUser();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 0 ,0, 25),
          child: Column(
            children: [
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
                                    child: Text(
                                      "Follower : "+ dataUser.followers,
                                      style: TextStyle(
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 0 ,20, 0),
                                    child: Text(
                                      "Following : "+ dataUser.following,
                                      style: TextStyle(
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
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
                    initialValue:  dataUser.full_name == null
                        ? ""
                        : dataUser.full_name,
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
                    initialValue: dataUser.telepon,
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
                    initialValue: dataUser.birth_place,
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
                    controller: inputController,
                    initialValue: dataUser.birth_date,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                        icon: Icon(Icons.date_range), labelText: "Tanggal Lahir"),
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true, onChanged: (date) {
                            print('change $date');
                          }, onConfirm: (date) {
                            print('confirm $date');
                            String date1 = date.toString().split(' ')[0];
                            String date2 = date.toString().split(' ')[1];
                            String time =
                                date2.split(':')[0] + ':' + date2.split(':')[1];
                            inputController.text = date1;
                          }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: TextFormField(
                    initialValue: dataUser.gender,
                    cursorColor: Theme.of(context).cursorColor,
                    decoration: InputDecoration(
                        icon: Icon(Icons.perm_identity), labelText: "Jenis Kelamin"),
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: FlatButton.icon(
                    onPressed: () {

                    },
                    icon: Icon(Icons.save),
                    label: Text("Simpan"),
                    textColor: Colors.white,
                    color: Theme.of(context).cursorColor,
                    minWidth: 350,
                  ),
                ),
              ),
              Center(
                child: Container(
                  child: FlatButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()));
                      Preferences().clearPreferences(context);
                    },
                    icon: Icon(Icons.logout),
                    label: Text("Keluar"),
                    textColor: Colors.white,
                    color: Theme.of(context).cursorColor,
                    minWidth: 350,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
