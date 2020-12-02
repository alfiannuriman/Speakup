import 'package:flutter/material.dart';
import 'package:speakup/views/pages/LoginPage.dart';
import 'package:speakup/views/pages/RegisterPage.dart';
import 'package:speakup/views/pages/AboutPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.png'), fit: BoxFit.cover)),
        child: Scaffold(
            appBar:
                AppBar(title: Text('SpeakUp - Share Stories From Around The World')),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/logo-primary-croped.PNG'),
                        fit: BoxFit.cover
                      )
                    ),
                  )
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text('Login'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        }),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text('Register'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        }),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text('About'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutPage()));
                        }),
                  ),
                ),
              ],
            ))));

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('SpeakUp - People Stories Social Media')
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         ElevatedButton(
    //           child: Text('Login'),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => LoginPage())
    //             );
    //           }
    //         ),
    //         ElevatedButton(
    //           child: Text('Register'),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => RegisterPage())
    //             );
    //           }
    //         ),
    //         ElevatedButton(
    //           child: Text('About'),
    //           onPressed: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(builder: (context) => AboutPage())
    //             );
    //           }
    //         )
    //       ],
    //     )
    //   )
    // );
  }
}
