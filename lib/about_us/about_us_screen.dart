import 'package:flutter/material.dart';
import 'package:khadamaty/utilities/theme_const.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteBG,
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Text(
            "About Us Screen",
            style: TextStyle(color: Constants.darkRed),
          ),
        ),
      ),
    );
  }
}
