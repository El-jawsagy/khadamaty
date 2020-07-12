import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:khadamaty/authentication/forntend/login_screen.dart';
import 'package:khadamaty/utilities/models_data.dart';
import 'package:khadamaty/utilities/theme_const.dart';

class OnBording extends StatefulWidget {
  bool lang;

  OnBording(
    this.lang,
  );

  @override
  _OnBordingState createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  bool last = false;
  int pagePos = 0;

  double opacity = 0;
  List<Page> onBordingPages;

  @override
  void initState() {
    onBordingPages = Page.onBordingAr();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'assets/images/landscap_logo.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height,
        ),
        Opacity(
          opacity: .55,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Constants.darkPrimary,
              Constants.darkPrimary,
            ])),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              PageView.builder(
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, position) {
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.2,
                        left: MediaQuery.of(context).size.width * .1,
                        child:
                            position != 0 ? _drawIcons(position) : _drawLogo(),
                      ),
                      _drawPage(position),
                    ],
                  );
                },
                onPageChanged: (pos) {
                  setState(() {
                    pagePos = pos;
                    if (pos == onBordingPages.length - 1) {
                      opacity = 1;
                    } else {
                      opacity = 0;
                    }
                  });
                },
                itemCount: onBordingPages.length,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 38),
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "/login");
                  },
                  child: Text(
                    "تخطي",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Constants.whiteBG,
                    ),
                  ),
                ),
              ),
//              Padding(
//                padding: EdgeInsets.only(
//                    left: MediaQuery.of(context).size.width - 50, top: 38),
//                child: InkWell(
//                  onTap: () {
//                    setState(() {
//                      print(widget.lang);
//                      Preferences.setLang(switchLang(widget.lang));
//                    });
//                  },
//                  child: Text(
//                    widget.lang == true ? "Ar" : "En",
//                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w600,
//                      color: Constants.whiteBG,
//                    ),
//                  ),
//                ),
//              ),
              Transform.translate(
                offset: Offset(0, 50),
                child: Center(
                  child: DotsIndicator(
                    dotsCount: onBordingPages.length,
                    position: pagePos.ceilToDouble(),
                    decorator: DotsDecorator(
                      color: Constants.whiteBG,
                      activeColor: Constants.darkRed,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 1000),
                child: Align(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 23, top: 23),
                    width: MediaQuery.of(context).size.width * 70,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LoginScreen(
                                widget.lang,
                              );
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Constants.darkRed,
                            ),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width * .45,
                            child: Text(
                              "تسجيل الدخول",
                              textScaleFactor: 1.8,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _drawPage(int pos) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height * 0.45,
          right: 0,
          left: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Text(
                    onBordingPages[pos].header,
                    style: TextStyle(
                      color: Constants.whiteBG,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .15,
                  child: Text(
                    onBordingPages[pos].description,
                    style: TextStyle(
                        color: Constants.whiteBG,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _drawIcons(int pos) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: Icon(
          onBordingPages[pos].iconData,
          size: MediaQuery.of(context).size.height * 0.15,
          color: Constants.whiteBG,
        ),
      ),
    );
  }

  Widget _drawLogo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(bottom: 16),
          width: MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.32,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: ExactAssetImage(
                    "assets/images/logo_in_white.png",
                  ),
                  fit: BoxFit.cover)),
          child: Center(),
        ),
      ),
    );
  }
}
