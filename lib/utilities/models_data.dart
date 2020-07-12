import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Page {
  IconData iconData;
  String header, description;

  Page([this.iconData, this.header, this.description]);

  static List<Page> onBordingAr() {
    List<Page> onBordingPages = [
      Page(FontAwesomeIcons.smileWink, "مرحبا", "نتمني ان تجد خدمتك فى خدماتي"),
      Page(
          FontAwesomeIcons.tools, "مقدم الخدمة", "الان يمكنك عرض خدمتك بسهولة"),
      Page(
        FontAwesomeIcons.user,
        "عميل",
        "الان يمكنك تصفح كل الخدمات من حولك",
      ),
      Page(FontAwesomeIcons.handsHelping, "كن جزء من خدماتي", "هيا لنجد خدمتك"),
    ];
    return onBordingPages;
  }

  static List<Page> onBordingen() {
    List<Page> onBordingPages = [
      Page(FontAwesomeIcons.smileWink, "Welcome",
          "we hope you've got enjoyed in khadamaty"),
      Page(
        FontAwesomeIcons.tools,
        "Service Provider",
        "Now you can easily reach out to the right people for your service",
      ),
      Page(
        FontAwesomeIcons.user,
        "Client",
        "Now you can explore all service around you",
      ),
      Page(FontAwesomeIcons.handsHelping, "Be part from Khadamaty",
          "Let's find your service"),
    ];
    return onBordingPages;
  }
}

//class DynamicDialog extends StatefulWidget {
//  final List<Service> categoryDialog;
//
//  DynamicDialog({this.categoryDialog});
//
//  @override
//  _DynamicDialogState createState() => _DynamicDialogState();
//}
//
//class _DynamicDialogState extends State<DynamicDialog> {
//  List<Service> _categoryDialog;
//
//  @override
//  void initState() {
//    _categoryDialog = widget.categoryDialog;
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      backgroundColor: Constants.darkRed,
//      title: Text(
//        'select category',
//        style: TextStyle(color: Colors.white),
//        textAlign: TextAlign.center,
//      ),
//      content:
//      ListView(
//        children: <Widget>[
//          _drawRowOfCategory(0, _categoryDialog),
//          _drawRowOfCategory(1, _categoryDialog),
//          _drawRowOfCategory(2, _categoryDialog),
//          _drawRowOfCategory(3, _categoryDialog),
//          _drawRowOfCategory(4, _categoryDialog),
//          _drawRowOfCategory(5, _categoryDialog),
//          _drawRowOfCategory(6, _categoryDialog),
//          _drawRowOfCategory(7, _categoryDialog),
//          _drawRowOfCategory(8, _categoryDialog),
//          _drawRowOfCategory(9, _categoryDialog),
//          _drawRowOfCategory(10, _categoryDialog),
//          _drawRowOfCategory(11, _categoryDialog),
//          _drawRowOfCategory(12, _categoryDialog),
//          _drawRowOfCategory(13, _categoryDialog),
//        ],
//      ),
//
//
//      actions: <Widget>[
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,
//          children: <Widget>[
//            MaterialButton(
//              color: Colors.white,
//              onPressed: () {
//                Navigator.of(context).pop(context);
//              },
//              child: Text(
//                'Done',
//                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//              ),
//            ),
//          ],
//        )
//      ],
//    );
//  }
//
//  _drawRowOfCategory(int pos, List<Service> categories) {
//    return Row(
//      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//      children: <Widget>[
//        Text(
//          categories[pos].name,
//          style: TextStyle(color: Colors.white),
//        ),
//        Switch(
//          value: categories[pos].val,
//          onChanged: (value) {
//            setState(() {
//              categories[pos].val = value;
//            });
//          },
//        )
//      ],
//    );
//  }
//}

class DrawerItem {
  String titleItem;
  IconData iconItem;
  String screenToGo;

  DrawerItem(this.titleItem, this.iconItem, this.screenToGo);
}

List<DrawerItem> getItemAr() {
  List<DrawerItem> items = [];
  items.add(
    DrawerItem("الصفحة الرئيسية", FontAwesomeIcons.home, '/home'),
  );

  items.add(
    DrawerItem("الخدمات الشائعة", FontAwesomeIcons.newspaper, '/trending'),
  );
  items.add(
    DrawerItem("صفحة التنبيهات", Icons.notifications, '/notification'),
  );
  items.add(
    DrawerItem("معلومات عنا", Icons.help, '/about'),
  );
  items.add(
    DrawerItem("تسجيل الخروج", FontAwesomeIcons.signOutAlt, '/logOut'),
  );

  return items;
}

List<DrawerItem> getItemEn() {
  List<DrawerItem> items = [];
  items.add(
    DrawerItem("Home Page", FontAwesomeIcons.home, '/home'),
  );

  items.add(
    DrawerItem("Trending services", FontAwesomeIcons.newspaper, '/trending'),
  );
  items.add(
    DrawerItem("Notification", Icons.notifications, '/notification'),
  );
  items.add(
    DrawerItem("About Us", Icons.help, '/about'),
  );
  items.add(
    DrawerItem("Logout", FontAwesomeIcons.signOutAlt, '/logOut'),
  );

  return items;
}

List friends = List.generate(
    13,
    (index) => {
          "name": names[Random().nextInt(10)],
          "dp": "assets/images/event_background.jpg",
          "status": "Anything could be here",
          "isAccept": Random().nextBool(),
        });
List names = [
  "mahmoud el jawsagy",
  "mohanad",
  "mohamad fat7y",
  "Ana w Anta",
  "Anta w homa",
  "mahmoud el jawsagy tany",
  "mohand tany brdo ",
  "mohamed la ",
  "mahmoud el jawsagy",
  "mohand tany brdo ",
  "mohamed la ",
  "mahmoud el jawsagy",
  "mohamed la ",
];

class PagesForPopup {
  static String addEvent = 'addEvent';
  static String eventHistory = 'eventHistory';
  static String settings = 'settings';
  static String notification = 'notification';
  static String addFriends = 'addFriends';
  static String about = 'about';
  static String help = 'help';
  static String feed = 'feed';
  static String cancel = 'cancel';

  static List<String> pages = [
    addEvent,
    eventHistory,
    settings,
    notification,
    addFriends,
    about,
    help,
    feed,
    cancel,
  ];
}

List notifs = [
  "${names[Random().nextInt(10)]} and ${Random().nextInt(100)} others liked your post",
  "${names[Random().nextInt(10)]} mentioned you in a comment",
  "${names[Random().nextInt(10)]} shared your post",
  "${names[Random().nextInt(10)]} commented on your post",
  "${names[Random().nextInt(10)]} replied to your comment",
  "${names[Random().nextInt(10)]} reacted to your comment",
  "${names[Random().nextInt(10)]} asked you to join a Group️",
  "${names[Random().nextInt(10)]} asked you to like a page",
  "You have memories with ${names[Random().nextInt(10)]}",
  "${names[Random().nextInt(10)]} Tagged you and ${Random().nextInt(100)} others in a post",
  "${names[Random().nextInt(10)]} Sent you a friend request",
];
List events = [
  'cairokee',
  'hossam hekal',
  'hazem elsadeek',
  'flutter workShop',
  'Tedx zag',
  'Ebrahim el 5oly',
  'cairokee 1',
  'hossam hekal 1',
  'hazem elsadeek 1',
  'flutter workShop 1',
  'Tedx zag 1',
  'Ebrahim el 5oly 1',
  'bladyt El ma7ala'
];

List notificationsPeople = List.generate(
    13,
    (index) => {
          "name": events[Random().nextInt(10)],
          "dp": "assets/images/photo.jpg",
          "time": "${Random().nextInt(50)} min ago",
          "notif": notifs[Random().nextInt(8)]
        });

class Event {
  String image;
  String title;
  String location;
  String type;
  String date;

  Event(
    this.image,
    this.title,
    this.type,
    this.location,
    this.date,
  );
}

List<Event> getEvent() {
  List<Event> events = [];
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  events.add(Event("assets/images/service.png", "Cairokee", "music",
      "12 Zagazig City, El sarqia, Egypt", "12 oct 2020"));
  return events;
}
