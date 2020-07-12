import 'package:flutter/material.dart';
import 'package:khadamaty/main_screen/service.dart';
import 'package:khadamaty/main_screen/trending_services/service_provider_screen.dart';
import 'package:khadamaty/main_screen/trending_services/trending_screen_api.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/theme_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeLineScreen extends StatefulWidget {
  bool lang;

  TimeLineScreen(this.lang);

  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  final GlobalKey<ScaffoldState> _timeLineScaffoldKey =
      new GlobalKey<ScaffoldState>();

  TrendingScreenApi trendingScreenApi = TrendingScreenApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkOne,
      key: _timeLineScaffoldKey,
      body: FutureBuilder(
          future: trendingScreenApi.fetchAllServices(),
          builder: (context, snapshots) {
            switch (snapshots.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return loading(context, MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height);
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshots.hasData) {
                  return buildBody(snapshots.data);
                } else
                  return emptyPage(context);
                break;
              default:
                return emptyPage(context);
            }
          }),
    );
  }

  Widget buildBody(List<Service> services) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: services.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ServiceProvidersScreen(
                          widget.lang, services[i])));
            },
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: services[i].image == null ||
                                  services[i].image == ""
                              ? Image.asset(
                                  'assats/images/logo_in_white.png',
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
                                    services[i].image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(flex: 1, child: buildTitle(services[i].name))
                      ],
                    ))),
          );
        });
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
    );
  }
}

setLanguage(bool language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('language', language);
}

getLanguage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isArabic = prefs.getBool('language');
  return isArabic;
}

setToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print("token is change");
  await preferences.setString("token", token);
}

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String isLogin = prefs.getString('token');
  print("the token from pref is $isLogin");
  return isLogin;
}
