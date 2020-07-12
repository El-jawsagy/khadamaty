import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:khadamaty/authentication/backend/authentication.dart';
import 'package:khadamaty/authentication/forntend/forget_password_screen.dart';
import 'package:khadamaty/authentication/forntend/signup_client_screen.dart';
import 'package:khadamaty/authentication/forntend/signup_provider_screen.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/multi_screen.dart';
import 'package:khadamaty/utilities/theme_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final bool lang;

  LoginScreen(
    this.lang,
  );

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController;

  TextEditingController _passwordTextController;

  IconData _icon = Icons.visibility_off;

  bool _isVisible = true;

  bool _isHash = true;

  final _formKey = GlobalKey<FormState>();

  Authentication auth = Authentication();

  @override
  void initState() {
    _passwordTextController = TextEditingController();
    _emailTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DetectedScreen detectedScreen = DetectedScreen(context);
    LoginScreenProperties loginScreenProperties =
        LoginScreenProperties(detectedScreen);
//WillPopScope make you can control with back button in android
    return WillPopScope(
      onWillPop: () {
        // @pop is function to make us navigation from screen to home android screen system
        return pop();
      },
      child: CustomPaint(
        painter: BackGround(),
        child: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .02),
                            _drawLogo(),
                            _drawEditText(
                                Icons.email,
                                'بريد الكتروني',
                                'من فضلك فم بادخال البريد الالكتروني',
                                loginScreenProperties.editTextSize),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .008),
                            _drawPasswordEditText(
                                loginScreenProperties.editTextSize),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01),
                            _drawForgetPass(
                                loginScreenProperties.forgetTextSize),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .07),
                            _drawLoginButton(
                                loginScreenProperties.loginTextSize),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: _drawSignUp(
                                    loginScreenProperties.signUpText),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawLogo() {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Image.asset(
        "assets/images/logo_in_white.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawEditText(IconData icon, String boxName, String validatorText,
      double titleTextSize) {
    return TextFormField(
      style: TextStyle(fontSize: titleTextSize),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextController,
      decoration: InputDecoration(
        labelText: boxName,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Constants.whiteBG,
        prefixIcon: Icon(
          icon,
          color: Constants.darkRed,
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }

  Widget _drawPasswordEditText(double textFontSize) {
    return TextFormField(
      style: TextStyle(
        fontSize: textFontSize,
      ),
      obscureText: _isHash,
      controller: _passwordTextController,
      decoration: InputDecoration(
        labelText: "كلمة السر",
        filled: true,
        fillColor: Constants.whiteBG,
        prefixIcon: Icon(
          Icons.lock,
          color: Constants.darkRed,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            if (_isVisible) {
              setState(() {
                _icon = Icons.visibility;
                _isHash = false;
                _isVisible = false;
                this._emailTextController.text = _emailTextController.text;
                this._passwordTextController.text =
                    _passwordTextController.text;
              });
            } else if (!_isVisible) {
              setState(() {
                _icon = Icons.visibility_off;
                _isHash = true;
                _isVisible = true;
                this._emailTextController.text = _emailTextController.text;
                this._passwordTextController.text =
                    _passwordTextController.text;
              });
            }
          },
          icon: Icon(
            _icon,
            color: Constants.darkRed,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return "من فضلك ادخل كلمة السر";
        }
        return null;
      },
    );
  }

  Widget _drawForgetPass(double forgetTextSize) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ForgetPassword(widget.lang)));
            },
            child: Text(
              "نسيت كلمت السر؟",
              style: TextStyle(
                fontSize: forgetTextSize,
                color: Constants.whiteBG,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawLoginButton(double textButtonSize) {
    return InkWell(
      onTap: () async {
        ValidateForm();
        //todo: make controllers empty
        //todo: make page loading after finish and nav to home
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        height: MediaQuery.of(context).size.height * .07,
        decoration: BoxDecoration(
          color: Constants.darkRed,
          boxShadow: [
            BoxShadow(
              color: Constants.whiteBG,
              blurRadius: .75,
              spreadRadius: .75,
              offset: Offset(0.0, 0.0),
            )
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            "تسجيل الدخول",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: textButtonSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawSignUp(
    double signUpScreen,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              showChooseButtons(signUpScreen, context);
            },
            child: Text(
              "انشاء حساب",
              style: TextStyle(
                  fontSize: 22,
                  color: Constants.darkRed,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Text(
          "  لا امتلك حساب؟",
          style: TextStyle(fontSize: 20, color: Constants.whiteBG),
        ),
      ],
    );
  }

  showChooseButtons(double str, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (c) {
        // return object of type Dialog
        return AlertDialog(
          //title: new Text("Alert Dialog title"),
          backgroundColor: Constants.darkOne,
          contentPadding: EdgeInsets.fromLTRB(40, 8, 40, 8),
          content: Container(
            width: MediaQuery.of(context).size.width * .8,
            height: MediaQuery.of(context).size.height * .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(c).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignUpClientScreen(widget.lang)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .07,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurRadius: .75,
                          spreadRadius: .75,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(50),
                      color: Constants.darkRed,
                    ),
                    child: Center(
                      child: Text(
                        "عميل",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: str,
                          color: Constants.whiteBG,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(c).pop();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            SignUpProviderScreen(widget.lang)));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .6,
                    height: MediaQuery.of(context).size.height * .07,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          blurRadius: .75,
                          spreadRadius: .75,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(50),
                      color: Constants.darkRed,
                    ),
                    child: Center(
                      child: Text(
                        "مقدم الخدمة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: str,
                          color: Constants.whiteBG,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "الغاء",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: str,
                  color: Constants.darkRed,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
// ignore: must_call_super
  void dispose() {
    _passwordTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  Future<void> pop() async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }

  Future<void> ValidateForm() {
    String name, pass;
    name = _emailTextController.text;
    pass = _passwordTextController.text;

    if (_formKey.currentState.validate()) {
      auth.logIn(context, name, pass).then((onVal) {
        if (onVal.length <= 50) {
          showDialogWidget("make sure of email or password", context);
        } else {
          Navigator.of(context).pushReplacementNamed("/home");
        }
      });
    }
  }
}

setLanguage(bool language) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('language', language);
}

setToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  print("token is change");
  await preferences.setString("token", token);
}

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String isLogin = prefs.getString('token');
  print("the token from pref is $isLogin");
  return isLogin;
}
