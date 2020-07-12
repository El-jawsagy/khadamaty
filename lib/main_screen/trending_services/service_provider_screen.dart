import 'dart:math';

import 'package:flutter/material.dart';
import 'package:khadamaty/main_screen/profile/provider_screen.dart';
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/main_screen/service.dart';
import 'package:khadamaty/main_screen/trending_services/trending_screen_api.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/theme_const.dart';

class ServiceProvidersScreen extends StatefulWidget {
  Service service;
  bool lang;

  ServiceProvidersScreen(this.lang, this.service);

  @override
  _ServiceProvidersScreenState createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen>
    with SingleTickerProviderStateMixin {
  TrendingScreenApi trendingScreenApi;

  @override
  void initState() {
    trendingScreenApi = TrendingScreenApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.darkOne,
      appBar: AppBar(
        title: Text(widget.service.name),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: trendingScreenApi.fetchAllServiceProviders(widget.service.id),
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
                  if (snapshots.data == null) {
                    print(snapshots.data);
                    return emptyPage(context);
                  }
                  return _drawServiceProvider(snapshots.data);
                } else
                  return emptyPage(context);
                break;
              default:
                return emptyPage(context);
            }
          }),
    );
  }

  Widget _drawServiceProvider(List<User> users) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      separatorBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 0.5,
            width: MediaQuery.of(context).size.width / 1.3,
            child: Divider(),
          ),
        );
      },
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width * .15,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: (users[index].imageProfile == null)
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
                          users[index].imageProfile,
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            contentPadding: EdgeInsets.all(0),
            title: Text(
              users[index].name,
              style: TextStyle(fontSize: 20, color: Colors.white70),
            ),
            trailing: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .15,
                  minHeight: MediaQuery.of(context).size.height * .1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    Random().nextInt(5).toString(),
                    style: TextStyle(fontSize: 18, color: Constants.whiteBG),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.star,
                    color: Constants.ratingBG,
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new ProviderScreen(
                          widget.lang, users[index], widget.service)));
            },
          ),
        );
      },
    );
  }
}
