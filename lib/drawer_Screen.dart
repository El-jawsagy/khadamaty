import 'package:flutter/material.dart';
import 'package:khadamaty/main.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/models_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utilities/theme_const.dart';

class DrawerScreen extends StatefulWidget {
  bool lang;

  DrawerScreen(this.lang);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<DrawerItem> drawerItems = [];
@override
  void initState() {
  drawerItems = widget.lang == true ? getItemAr() : getItemEn();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            color: Constants.darkRed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                    fit: FlexFit.loose,
                    flex: 1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: ExactAssetImage(
                              "assets/images/photo.jpg",
                            ),
                            radius: MediaQuery.of(context).size.height * 0.045,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Mahmoud Ragab",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.blueGrey,
                                        blurRadius: 1.5,
                                      ),
                                    ]),
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .30,
                                height:
                                    MediaQuery.of(context).size.height * .045,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Service name",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 9,
                  child: Container(
                    color: Constants.darkRed,
                    child: ListView.builder(
                      itemBuilder: (context, position) {
                        return InkWell(
                          onTap: () async {
                            if (drawerItems[position].screenToGo == '/logOut') {
                              print("now is done");
                              setToken(null);
                              Navigator.pushReplacementNamed(
                                context,
                                drawerItems[position].screenToGo,
                              );
                            } else {
                              Navigator.pushReplacementNamed(
                                context,
                                drawerItems[position].screenToGo,
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ListTile(
                              title: Text(
                                drawerItems[position].titleItem,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                              trailing: Icon(
                                drawerItems[position].iconItem,
                                color: Constants.whiteBG,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: drawerItems.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Constants.darkOne,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              margin: EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: InkWell(
                onTap: () async {
                  setState(() {
                    setLanguage(switchLang(widget.lang));
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Khadamaty()));
                },
                child: Text(
                  widget.lang == true ? "English" : "العربية",
                  style: TextStyle(
                      fontSize: 20,
                      color: Constants.ratingBG,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
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
