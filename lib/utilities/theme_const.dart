import 'package:flutter/material.dart';

class Constants {
  static String appName = "EvnTown";

  //Colors for theme
  static Color lightPrimary = Color(0xff8c0c0c);
  static Color darkPrimary = Colors.black;
  static Color blue = Colors.blueAccent;
  static Color darkBlue = Color(0xff5563ff);
  static Color darkRed = Color(0xff8c0c0c);
  static Color darkOne = Color(0xff262828);
  static Color gray = Colors.grey;
  static Color whiteBG = Colors.white;
  static Color ratingBG = Colors.yellow[600];
  static Color offWhite = Colors.white70;

  static ThemeData lightTheme = ThemeData(
    backgroundColor: darkRed,
    primaryColor: lightPrimary,
    accentColor: blue,
    cursorColor: blue,
    scaffoldBackgroundColor: darkRed,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: whiteBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    canvasColor: Constants.darkRed,
    brightness: Brightness.dark,
    backgroundColor: whiteBG,
    primaryColor: darkPrimary,
    accentColor: darkBlue,
    scaffoldBackgroundColor: whiteBG,
    cursorColor: whiteBG,
    fontFamily: 'rubik',
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        title: TextStyle(
          color: darkRed,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );
}

class BackGround extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Constants.darkOne;
    canvas.drawPaint(paint);
    Path path1 = Path();
    path1.lineTo(0, 0);
    path1.lineTo(0, size.height * 0.2);
    path1.quadraticBezierTo(
        size.width * .5, size.height * .55, size.width, size.height * .18);
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    paint.color = Constants.darkRed;
    path1.close();
    canvas.drawPath(path1, paint);
    Path path2 = Path();
    path2.lineTo(size.width, size.height * 0.75);
    path2.quadraticBezierTo(
        size.width * 0.6, size.height * .8, size.width * 0.5, size.height);
    path2.lineTo(size.width, size.height);

    path2.lineTo(size.width, size.height * 0.75);
    paint.color = Constants.darkRed;
    path2.close();
    canvas.drawPath(path2, paint);
    Path path3 = Path();
    path3.lineTo(0, size.height * 0.35);
    path3.quadraticBezierTo(
        size.width * 0.4, size.height * .45, 0, size.height * 0.7);

    path3.lineTo(0, size.height * 0.45);
    paint.color = Constants.darkRed;
    path3.close();
    canvas.drawPath(path3, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
