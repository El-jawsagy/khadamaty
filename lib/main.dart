import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khadamaty/about_us/about_us_screen.dart';
import 'package:khadamaty/authentication/forntend/signup_provider_screen.dart';
import 'package:khadamaty/utilities/preferences.dart';
import 'package:khadamaty/utilities/theme_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication/forntend/login_screen.dart';
import 'authentication/forntend/signup_client_screen.dart';
import 'main_screen/main_screen.dart';

void main() {
  runApp(SetYouLanguage());
}

class SetYouLanguage extends StatefulWidget {
  @override
  _SetYouLanguageState createState() => _SetYouLanguageState();
}

class _SetYouLanguageState extends State<SetYouLanguage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Preference.getLanguage(),
          builder: (BuildContext context, AsyncSnapshot snapShot) {
            if (snapShot.hasData) {
              return Khadamaty();
            }

            return SetIt();
          },
        ));
  }
}

class SetIt extends StatefulWidget {
  @override
  _SetItState createState() => _SetItState();
}

class _SetItState extends State<SetIt> {
  @override
  void initState() {
    setLanguage(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Khadamaty();
  }
}

class Khadamaty extends StatefulWidget {
  Khadamaty();

  @override
  _KhadamatyState createState() => _KhadamatyState();
}

class _KhadamatyState extends State<Khadamaty> {
  bool isDark = false;

  //todo: make app can't back to onBoarding when app go to home screen

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Preference.getLanguage(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: MaterialApp(
              routes: {
                '/home': (context) => MainScreen(0, snapshot.data),
                '/trending': (context) => MainScreen(1, snapshot.data),
                '/notification': (context) => MainScreen(2, snapshot.data),
                '/profile': (context) => MainScreen(3, snapshot.data),
                '/signAsPro': (context) => SignUpProviderScreen(
                      snapshot.data,
                    ),
                '/signAsClient': (context) => SignUpClientScreen(
                      snapshot.data,
                    ),
                '/about': (context) => AboutUsScreen(),
                //todo:create an screen to add service in app
                '/addService': (context) => AboutUsScreen(),
                '/login': (context) => LoginScreen(
                      snapshot.data,
                    ),
                '/logOut': (context) => LoginScreen(
                      snapshot.data,
                    ),
              },
              debugShowCheckedModeBanner: false,
              theme: Constants.lightTheme,
              home: WillPopScope(
                onWillPop: () {
                  // @pop is function to make us navigation from screen to home android screen system
                  return pop();
                },
                child: HomePage(
                  snapshot.data,
                ),
              ),
            ),
          );
        });
  }
}

class HomePage extends StatefulWidget {
  final bool lang;

  HomePage(
    this.lang,
  );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Preference.getToken(),
      builder: (context, AsyncSnapshot snapshot) {
        print("the lang is ${widget.lang}");
        if (snapshot.hasData) {
          return MainScreen(
            0,
            widget.lang,
          );
        } else {
          return LoginScreen(widget.lang);
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

setLanguage(bool language) async {
  bool lang = await Preference.getLanguage();
  if (lang == null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('language', language);
  }
}

Future<void> pop() async {
  await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
}

setToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("token", token);
}
