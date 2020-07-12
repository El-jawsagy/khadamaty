import 'package:flutter/material.dart';
import 'package:khadamaty/main_screen/profile/user.dart';

class EditProfileScreen extends StatefulWidget {
  bool lang;
  User user;


  EditProfileScreen(this.lang, this.user);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();

}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
