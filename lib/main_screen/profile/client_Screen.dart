import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khadamaty/main_screen/profile/profile_api.dart';
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/theme_const.dart';

class ClientScreen extends StatefulWidget {
  bool lang;

  ClientScreen(this.lang);

  @override
  _ClientScreenState createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen>
    with SingleTickerProviderStateMixin {
  static Random random = Random();

  TabController _tabController;
  ProfileApi profileApi;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    profileApi = ProfileApi();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: profileApi.fetchUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(
                child: noConnection(context, .85, .35),
              );
              break;
            case ConnectionState.waiting:
            case ConnectionState.waiting:
              return loading(context, 0.85, .35);
              break;
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return error(
                  context,
                  snapshot.error,
                  0.85,
                  .35,
                );
              } else {
                if (snapshot.hasData) {
                  User user = snapshot.data;
                  return bodyScreen(user);
                } else if (!snapshot.hasData) {
                  return noData(context, 0.85, .35);
                }
              }
              break;
          }
          return noData(context, 0.85, .35);
        });
  }

  Widget bodyScreen(User user) {
    return Scaffold(
      backgroundColor: Constants.darkOne,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 10),
                  _drawPhoto(user.imageProfile),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      user.name,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
                  ),
                  _drawPhoneNumber(user.phoneNumber.toString()),
                  _drawTagsRow(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: widget.lang == true
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.lang == true
                              ? "اعمال سابقة "
                              : "Previous services",
                          style: TextStyle(
                              fontSize: 20,
                              color: Constants.ratingBG,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  _drawAboutMe(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon:
                          Icon(FontAwesomeIcons.edit, color: Constants.whiteBG),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawPhoto(String imageUrl) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Opacity(
          opacity: .6,
          child: Container(
            width: MediaQuery.of(context).size.width * .33,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(9),
              color: Constants.ratingBG,
            ),
          ),
        ),
        Opacity(
          opacity: .25,
          child: Container(
            width: MediaQuery.of(context).size.width * .3,
            height: MediaQuery.of(context).size.height * 0.14,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(9),
              color: Constants.ratingBG,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width * .25,
            height: MediaQuery.of(context).size.height * 0.16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: (imageUrl == null)
                ? Image.asset(
                    "assets/images/unknown.jpg",
                  )
                : Image(
                    loadingBuilder:
                        (context, image, ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        return image;
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    image: NetworkImage(
                      imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _drawPhoneNumber(String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          number == 'null'
              ? InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'friends');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Constants.darkRed,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          7,
                        ),
                      ),
                    ),
                    child: Text(
                      widget.lang == true
                          ? "لا يوجد رقم حاليا"
                          : "Don't have number",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'friends');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Constants.darkRed,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          7,
                        ),
                      ),
                    ),
                    child: Text(
                      number,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _drawTagsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.lang == true ? "نوع الخدمة" : "Service type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Constants.ratingBG,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                        child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "نجار",
                          style: TextStyle(
                              color: Constants.ratingBG,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawAboutMe() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onLongPress: () {
              //todo : Link with alert dialog to view story
            },
            onDoubleTap: () {
              //todo : Link with alert dialog to view story
            },
            onTap: () {
              //todo : Link with alert dialog to view story
            },
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/service.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        reverse: widget.lang == true ? true : false,
        itemCount: 10,
      ),
    );
  }
}
