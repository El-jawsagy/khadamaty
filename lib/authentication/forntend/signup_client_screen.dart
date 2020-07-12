import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khadamaty/authentication/backend/authentication.dart';
import 'package:khadamaty/main_screen/main_screen.dart';
import 'package:khadamaty/utilities/SimilarWidgets.dart';
import 'package:khadamaty/utilities/theme_const.dart';

import 'login_screen.dart';

class SignUpClientScreen extends StatefulWidget {
  final bool lang;

  SignUpClientScreen(this.lang);

  @override
  _SignUpClientScreenState createState() => _SignUpClientScreenState();
}

class _SignUpClientScreenState extends State<SignUpClientScreen> {
  final _signUpKey = GlobalKey<FormState>();
  Authentication auth = Authentication();

  IconData _icon = Icons.visibility_off;

  bool _isVisible = true;

  bool _isHash = true;

  IconData _iconConf = Icons.visibility_off;

  bool _isVisibleConf = true;

  bool _isHashConf = true;

  TextEditingController _nameEditingText;

  TextEditingController _passwordEditingText;

  TextEditingController _conformPassEditingText;

  TextEditingController _phoneEditingText;

  TextEditingController _emailEditingText;

  @override
  void initState() {
    _nameEditingText = TextEditingController();
    _emailEditingText = TextEditingController();
    _phoneEditingText = TextEditingController();
    _passwordEditingText = TextEditingController();
    _conformPassEditingText = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackGround(),
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Form(
                      key: _signUpKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "انشاء حساب عميل",
                            style: TextStyle(
                                color: Constants.whiteBG,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          Text(
                            "! سجل لطلب اول خدماتك",
                            style: TextStyle(
                              color: Constants.whiteBG,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .05),
                          _drawName(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .015),
                          _drawEmail(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .015),
                          _drawPhone(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .015),
                          _drawPasswordEditText(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .015),
                          _drawConfPasswordEditText(),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .07),
                          _drawSignUpButton(),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .015),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: _drawLogin(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
//                Align(
//                    alignment: Alignment.bottomCenter,
//                    child:
//                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawName() {
    return TextFormField(
      controller: _nameEditingText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Constants.whiteBG,
        labelText: 'الاسم',
        labelStyle: TextStyle(
          color: Constants.darkRed,
        ),
        prefixIcon: Icon(
          Icons.person,
          color: Constants.darkRed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return "من فضلك قم بادخال الاسم";
        }
        return null;
      },
    );
  }

  Widget _drawEmail() {
    return TextFormField(
      controller: _emailEditingText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Constants.whiteBG,
        labelText: 'البريد الالكتروني',
        labelStyle: TextStyle(
          color: Constants.darkRed,
        ),
        prefixIcon: Icon(
          Icons.email,
          color: Constants.darkRed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return "من فضلك قم بادخال بريدك الاكتروني";
        }
        return null;
      },
    );
  }

  Widget _drawPhone() {
    return TextFormField(
      controller: _phoneEditingText,
      keyboardType: TextInputType.numberWithOptions(signed: true),
      decoration: InputDecoration(
        filled: true,
        fillColor: Constants.whiteBG,
        labelText: 'رقم الهاتف',
        labelStyle: TextStyle(
          color: Constants.darkRed,
        ),
        prefixIcon: Icon(
          Icons.phone,
          color: Constants.darkRed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return "من فضلك قم بادخال رقم الهاتف";
        }
        return null;
      },
    );
  }

  Widget _drawPasswordEditText() {
    return TextFormField(
      obscureText: _isHash,
      controller: _passwordEditingText,
      decoration: InputDecoration(
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
                this._phoneEditingText.text = _phoneEditingText.text;
                this._nameEditingText.text = _nameEditingText.text;
                this._conformPassEditingText.text =
                    _conformPassEditingText.text;
                this._passwordEditingText.text = _passwordEditingText.text;
              });
            } else if (!_isVisible) {
              setState(() {
                _icon = Icons.visibility_off;
                _isHash = true;
                _isVisible = true;
                this._phoneEditingText.text = _phoneEditingText.text;
                this._nameEditingText.text = _nameEditingText.text;
                this._conformPassEditingText.text =
                    _conformPassEditingText.text;
                this._passwordEditingText.text = _passwordEditingText.text;
              });
            }
          },
          icon: Icon(
            _icon,
            color: Constants.darkRed,
          ),
        ),
        labelText: "كلمة السر",
        labelStyle: TextStyle(
          color: Constants.darkRed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return "من فضلك قم بادخال كلمة السر";
        }
        return null;
      },
    );
  }

  Widget _drawConfPasswordEditText() {
    return TextFormField(
      obscureText: _isHashConf,
      controller: _conformPassEditingText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Constants.whiteBG,
        prefixIcon: Icon(
          Icons.lock,
          color: Constants.darkRed,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            if (_isVisibleConf) {
              setState(() {
                _iconConf = Icons.visibility;
                _isHashConf = false;
                _isVisibleConf = false;
                this._phoneEditingText.text = _phoneEditingText.text;
                this._nameEditingText.text = _nameEditingText.text;
                this._conformPassEditingText.text =
                    _conformPassEditingText.text;
                this._passwordEditingText.text = _passwordEditingText.text;
              });
            } else if (!_isVisibleConf) {
              setState(() {
                _iconConf = Icons.visibility_off;
                _isHashConf = true;
                _isVisibleConf = true;
                this._phoneEditingText.text = _phoneEditingText.text;
                this._nameEditingText.text = _nameEditingText.text;
                this._conformPassEditingText.text =
                    _conformPassEditingText.text;
                this._passwordEditingText.text = _passwordEditingText.text;
              });
            }
          },
          icon: Icon(
            _iconConf,
            color: Constants.darkRed,
          ),
        ),
        labelText: "تاكيد كلمة السر",
        labelStyle: TextStyle(
          color: Constants.darkRed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (onValue) {
        if (onValue.isEmpty) {
          return "من فضلك اعد كتابة كلمة السر";
        } else if (onValue.isNotEmpty) {
          if (onValue == _passwordEditingText.text) {
            return null;
          }
          return "كلمة السر غير متطابقة";
        }
        return null;
      },
    );
  }

  Widget _drawSignUpButton() {
    return InkWell(
      onTap: () async {
        //todo: link it with firebase and with fireStore
        //todo: make controllers empty
        //todo: make page loading after finish and nav to home

        String name, pass, email, phone;
        int type = 0;
        name = _nameEditingText.text;
        email = _emailEditingText.text;
        phone = _phoneEditingText.text;
        pass = _passwordEditingText.text;

        if (_signUpKey.currentState.validate()) {
          print("this is name $name");
          print("this is pass $pass");
          print("this is email $email");
          print("this is phone $phone");
          auth
              .signUpAsClient(
                  email: email,
                  password: pass,
                  name: name,
                  phoneNumber: phone,
                  type: type)
              .then((Val) {
            if (Val.length <= 50) {
              switch (Val) {
                case "email exist":
                  showDialogWidget(
                      widget.lang
                          ? 'الاميل موجود بالفعل'
                          : "Email is already used",
                      context);
                  break;
              }
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MainScreen(0, widget.lang)));
            }
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .06,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: .75,
              spreadRadius: .75,
              offset: Offset(0.0, 0.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          gradient:
              LinearGradient(colors: [Constants.darkRed, Constants.darkRed]),
        ),
        child: Center(
          child: Text(
            "انشاء حساب",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawLogin() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginScreen(widget.lang)),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "تسجيل الدخول",
            style: TextStyle(
                fontSize: 22,
                color: Constants.darkRed,
                fontWeight: FontWeight.bold),
          ),
          Text(
            "  بالفعل امتلك حساب ؟",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Constants.whiteBG,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordEditingText.dispose();

    _conformPassEditingText.dispose();

    _nameEditingText.dispose();

    _phoneEditingText.dispose();

    _icon = Icons.visibility_off;

    _isVisible = true;

    _isHash = true;

    _iconConf = Icons.visibility_off;

    _isVisibleConf = true;

    _isHashConf = true;

    super.dispose();
  }
}
