import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khadamaty/utilities/theme_const.dart';


  showDialogWidget(String str, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title: new Text("Alert Dialog title"),
          content: new Text(str),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }


showWaiting(BuildContext contxt) {
  // flutter defined function
  showDialog(
    context: contxt,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        backgroundColor: Colors.transparent,
        title: new Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

Widget emptyPage(BuildContext context,) {
  return Container(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text(
            "Page is Empty",
            style: TextStyle(
                color: Constants.whiteBG,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

bool switchLang(bool lang) {
  switch (lang) {
    case true:
      return false;
      break;
    case false:
      return true;
      break;
  }
  return true;
}

Widget loading(BuildContext context, double width, double height) {
  return Container(
    width: MediaQuery.of(context).size.width * width,
    height: MediaQuery.of(context).size.height * height,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget noData(BuildContext context, double width, double height) {
  return Container(
    width: MediaQuery.of(context).size.width * width,
    height: MediaQuery.of(context).size.height * height,
    child: Center(
      child: Text("NO DATA"),
    ),
  );
}

Widget error(BuildContext context, Error error, double width, double height) {
  return Container(
    width: MediaQuery.of(context).size.width * width,
    height: MediaQuery.of(context).size.height * height,
    child: Center(
      child: Text("we found Error -> $error"),
    ),
  );
}

Widget noConnection(BuildContext context, double width, double height) {
  return Container(
    width: MediaQuery.of(context).size.width * width,
    height: MediaQuery.of(context).size.height * height,
    child: Center(
      child: Text(
        "No Connection with INTERNET",
      ),
    ),
  );
}
