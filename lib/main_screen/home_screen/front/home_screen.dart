import 'package:flutter/material.dart';
import 'package:khadamaty/main_screen/home_screen/backend/home_api.dart';
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/main_screen/service.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/models_data.dart';
import 'package:khadamaty/utilities/theme_const.dart';

import 'trending_service.dart';

class HomeScreen extends StatefulWidget {
  bool lang;

  HomeScreen(this.lang);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  final TextEditingController _homeSearchControl = new TextEditingController();
  final GlobalKey<ScaffoldState> _homeScaffoldKey =
      new GlobalKey<ScaffoldState>();
  HomeScreenApi homeScreenApi;

  @override
  bool get wantKeepAlive => true;
  int featurePos = 1;

  List<Event> events = [];

  @override
  void initState() {
    homeScreenApi = HomeScreenApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    events = getEvent();
    return Scaffold(
      key: _homeScaffoldKey,
      backgroundColor: Constants.darkOne,
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: widget.lang == true
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.lang == true
                        ? "ألخدمات الشائعة"
                        : "Trending services",
                    style: TextStyle(
                      color: Constants.whiteBG,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
//                FlatButton(
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Container(
//                        child: Icon(
//                          Icons.keyboard_arrow_right,
//                          color: Constants.ratingBG,
//                          size: MediaQuery.of(context).size.height * 0.05,
//                        ),
//                      ),
//                    ],
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).push(
//                      MaterialPageRoute(
//                        builder: (BuildContext context) {
//                          return TrendingServiceScreen(widget.lang);
//                        },
//                      ),
//                    );
//                  },
//                ),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            //Horizontal List here
            _drawTrendingEvent(),
            SizedBox(height: 30.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: widget.lang == true
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.lang == true ? "المستخدمين" : "users",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: Constants.whiteBG,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            //Horizontal List here
            Container(
              child: FutureBuilder(
                  future: homeScreenApi.fetchUsers(),
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
                            List<User> users = snapshot.data;
                            return _drawUser(snapshot.data);
                          } else if (!snapshot.hasData) {
                            return noData(context, 0.85, .35);
                          }
                        }
                        break;
                    }
                    return noData(context, 0.85, .35);
                  }),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _drawTrendingEvent() {
    return FutureBuilder(
        future: homeScreenApi.fetchServices(),
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
                  List<Service> services = snapshot.data;
                  return Container(
                    height: MediaQuery.of(context).size.height / 2.4,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: services.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: TrendingItem(
                            lang: widget.lang,
                            width: 0.8,
                            height: 3,
                            imageHeight: 4.5,
                            service: services[index],
                          ),
                        );
                      },
                    ),
                  );
                } else if (!snapshot.hasData) {
                  return noData(context, 0.85, .35);
                }
              }
              break;
          }
          return noData(context, 0.85, .35);
        });
  }

  Widget _drawUser(List<User> users) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.height / 6,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              child: Column(

                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height *0.12,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: InkWell(
                      onTap: () {
//                Navigator.of(context).push(MaterialPageRoute(
//                  builder: (context)=>ProviderScreen(widget.lang,users[index],)
//                ));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(),
                              child: (users[index].imageProfile == null)
                                  ? Image.asset(
                                      "assets/images/unknown.jpg",
                                    )
                                  : Image(
                                      loadingBuilder: (context, image,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) {
                                          return image;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      image: NetworkImage(
                                        users[index].imageProfile,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Opacity(
                              opacity: .2,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Constants.darkOne,
                                    Constants.darkOne,
                                  ]),
                                ),
                                height: MediaQuery.of(context).size.height / 6,
                                width: MediaQuery.of(context).size.height / 6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  Container(
                    padding: EdgeInsets.all(1),
                    constraints: BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Center(
                      child: Text(
                        users[index].name == null
                            ? (widget.lang == true ? "لا يوجد اسم" : "unknown")
                            : users[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _homeSearchControl.dispose();
    super.dispose();
  }
}
