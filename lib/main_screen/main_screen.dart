import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khadamaty/drawer_Screen.dart';
import 'package:khadamaty/main_screen/profile/client_Screen.dart';
import 'package:khadamaty/main_screen/profile/profile_api.dart';
import 'package:khadamaty/main_screen/trending_services/trending_service_screen.dart';
import 'package:khadamaty/utilities/theme_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen/front/home_screen.dart';
import 'notification/notification_Screen.dart';

class MainScreen extends StatefulWidget {
  int pos = 0;
  bool lang;

  @override
  _MainScreenState createState() => _MainScreenState();

  MainScreen(this.pos, this.lang);
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  Timer timer;
  ProfileApi profileApi = ProfileApi();

  @override
  void initState() {
    profileApi.fetchUser();
    _page = widget.pos;
    super.initState();
    _pageController = PageController(
      initialPage: _page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkOne,
      appBar: AppBar(
        title: Text(
          widget.lang == true ? "خدماتي" : "khadamaty",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerScreen(widget.lang),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          HomeScreen(widget.lang),
          TimeLineScreen(widget.lang),
          NotificationScreen(widget.lang),
          ClientScreen(widget.lang),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            IconButton(
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              color: _page == 0 ? Constants.ratingBG : Colors.white70,
              onPressed: () => _pageController.jumpToPage(0),
            ),
            IconButton(
              icon: Icon(
                Icons.label,
                size: 24.0,
              ),
              color: _page == 1 ? Constants.ratingBG : Colors.white70,
              onPressed: () => _pageController.jumpToPage(1),
            ),
            IconButton(
              icon: Icon(
                Icons.notifications,
                size: 24.0,
              ),
              color: _page == 2 ? Constants.ratingBG : Colors.white70,
              onPressed: () => _pageController.jumpToPage(2),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              color: _page == 3 ? Constants.ratingBG : Colors.white70,
              onPressed: () => _pageController.jumpToPage(3),
            ),
            SizedBox(width: 7),
          ],
        ),
        color: Constants.darkRed,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}

setLanguage(bool language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('language', language);
}

setToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print("token is change");
  await preferences.setString("token", token);
}
