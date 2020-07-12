import 'package:flutter/material.dart';
import 'package:khadamaty/authentication/backend/authentication.dart';
import 'package:khadamaty/main_screen/main_screen.dart';
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/utilities/theme_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPassword extends StatefulWidget {
  String token;
  bool lang;

  ResetPassword(this.lang, {this.token});

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  Authentication auth = Authentication();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Foget Password"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildLogo(size),
              //-----------------password Field-------------------------------------------------
              Container(
//      padding: EdgeInsets.only(left: 20, right: 15),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    //suffixIcon: buildEye(visible),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "password_shouldnt_be_empty";
                    } else if (value.length < 6) {
                      return "password_should_be_long";
                    }
                    return null;
                  },
                ),
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height / 30,
                    0,
                    MediaQuery.of(context).size.height / 30,
                    MediaQuery.of(context).size.height / 30),
              ),
              //-----------------------------------------------------------------------------

              Container(
                child: TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "The Password cannot be empty";
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        return "Not Matched";
                      }
                      return null;
                    }),
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height / 30,
                    0,
                    MediaQuery.of(context).size.height / 30,
                    MediaQuery.of(context).size.height / 30),
              ),

              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 35),
                child: FlatButton(
                  onPressed: () {
                    // TODO: implement validate function
//          validate();
                    // Navigator.pop(context);
                    validateForm();
                  },
                  child: Text(
                    "Forget Password",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  shape: StadiumBorder(),
                  color: Constants.darkRed,
                  //splashColor: Colors.indigo,
                  padding: EdgeInsets.fromLTRB(
                      size.width / 8, 15, size.width / 8, 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Container(
      child: Image.asset(
        "assets/images/logo_in_white.png",
        height: size.height / 3,
        width: size.width / 2,
        fit: BoxFit.contain,
      ),
//      margin: EdgeInsets.all(20),
    );
  }

  Future<void> validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      SharedPreferences pre = await SharedPreferences.getInstance();

      User user = await auth.createAndForgetUser(
        context,
        passwordController.text,
        widget.token,
      );
      //print(newUser.toMap());

      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainScreen(0, widget.lang)),
            ModalRoute.withName('/ResetPassword'));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt("idPref", /*3*/ user.id);
        await prefs.setString("namePref", user.name);
        await prefs.setString("emailPref", user.email);
        await prefs.setString("phonePref", user.phoneNumber);
        await prefs.setString("token", user.token);
      }

      formState.reset();
    }
  }
}
