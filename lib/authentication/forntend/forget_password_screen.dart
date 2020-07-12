import 'package:flutter/material.dart';
import 'package:khadamaty/authentication/backend/authentication.dart';
import 'package:khadamaty/authentication/forntend/reset_password_screen.dart';
import 'package:khadamaty/main_screen/profile/user.dart';
import 'package:khadamaty/utilities/theme_const.dart';

class ForgetPassword extends StatefulWidget {
  bool lang;

  ForgetPassword(this.lang);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return CustomPaint(
      painter: BackGround(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Constants.darkRed,
          elevation: 0,
          title: Text("Forget Password"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: <Widget>[
                  buildLogo(size),
                  //-----------------Email Field-------------------------------------------------
                  _drawNameOrEmail(
                    emailController,
                    'رقم الهاتف',
                    "من فضلك قم بادخال رقم الهاتف",
                    Icons.phone,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  //-----------------------------------------------------------------------------
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
                        style:
                            TextStyle(color: Constants.whiteBG, fontSize: 20),
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

  Widget _drawNameOrEmail(
    TextEditingController controller,
    String title,
    String errorMassage,
    IconData icon,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: title == "رقم الهاتف"
          ? TextInputType.numberWithOptions(signed: true)
          : null,
      decoration: InputDecoration(
        filled: true,
        fillColor: Constants.whiteBG,
        labelText: title,
        labelStyle: TextStyle(
          color: Constants.darkRed,
        ),
        prefixIcon: Icon(
          icon,
          color: Constants.darkRed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return errorMassage;
        }
        return null;
      },
    );
  }

  Future<void> validateForm() async {
    FormState formState = _formKey.currentState;

    if (formState.validate()) {
      //SharedPreferences prefs = await SharedPreferences.getInstance();

      User user = await auth.forgetPassword(context, emailController.text);
      //print(newUser.toMap());
      if (user != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ResetPassword(widget.lang, token: '${user.id}');
        }));
        /*SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("idPref", /*3*/ user.userID);
        prefs.setString("namePref", user.name);
        prefs.setString("emailPref", user.email);
        prefs.setString("phonePref", user.phoneNumber);
        prefs.setString("tokenPref", user.token);*/
      }
      formState.reset();
    }
  }
}
