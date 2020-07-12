import 'package:flutter/material.dart';
import 'package:khadamaty/utilities/models_data.dart';
import 'package:khadamaty/utilities/theme_const.dart';

class NotificationScreen extends StatefulWidget {
  bool lang;

  NotificationScreen( this.lang);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Constants.darkOne,
        body: _drawNotificationPeople(),
      ),
    );
  }

  Widget _drawNotificationPeople() {
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
      itemCount: notificationsPeople.length,
      itemBuilder: (BuildContext context, int index) {
        Map notificationPeople = notificationsPeople[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                notificationPeople['dp'],
              ),
              radius: 25,
            ),
            contentPadding: EdgeInsets.all(0),
            title: Text(
              notificationPeople['notif'],
              style: TextStyle(color: Colors.white70),
            ),
            trailing: Text(
              notificationPeople['time'],
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 11,
              ),
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
