import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khadamaty/utilities/theme_const.dart';

import 'main_screen.dart';

class BankNumber extends StatelessWidget {
  bool lang;

  BankNumber(this.lang);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackGround(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height * .2),
                    child: Text(
                      "تم ارسال الطلب بنجاح, سوف نتواصل معك",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.height * .5,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.white10,
                  child: ListView(
                    children: <Widget>[
                      _drawBankName(": البنك الراجحي "),
                      SizedBox(
                        height: 2,
                      ),
                      _drawBankNumber("525608010017040"),
                      SizedBox(
                        height: 1,
                      ),
                      _drawIpanName(),
                      SizedBox(
                        height: 4,
                      ),
                      _drawIpanNumber("SA23800005256080100170"),
                      SizedBox(
                        height: 4,
                      ),
                      _drawBankName(": البنك الاهلي "),
                      SizedBox(
                        height: 2,
                      ),
                      _drawBankNumber("10949742000109 "),
                      SizedBox(
                        height: 1,
                      ),
                      _drawIpanName(),
                      SizedBox(
                        height: 4,
                      ),
                      _drawIpanNumber("SA5650000000054112923002"),
                      SizedBox(
                        height: 4,
                      ),
                      _drawBankName(": البنك الهولندي "),
                      SizedBox(
                        height: 2,
                      ),
                      _drawBankNumber("054112923002 "),
                      SizedBox(
                        height: 1,
                      ),
                      _drawIpanName(),
                      SizedBox(
                        height: 4,
                      ),
                      _drawIpanNumber("SA1210000010949742000109"),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width,
                        maxHeight: MediaQuery.of(context).size.height * .2),
                    child: Text(
                      "يرجي سداد قيمة الخدمة علي احد هذه الحسابات حتي نقوم بتفعيل الطلب",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _drawBackButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawBankName(String bankName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          bankName,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 30,
        )
      ],
    );
  }

  Widget _drawBankNumber(String bankNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          bankNumber,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _drawIpanName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          "رقم الايبان",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 30,
        )
      ],
    );
  }

  Widget _drawIpanNumber(String IpanNumber) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          IpanNumber,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  Widget _drawBackButton(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () {
          // TODO: implement validate function

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainScreen(0, lang)));
        },
        child: Text(
          lang == true ? " الصفحة الرئيسية" : "Home page",
          style: TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        shape: StadiumBorder(),
        color: Colors.yellow,
        //splashColor: Colors.indigo,
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 6, 15,
            MediaQuery.of(context).size.width / 6, 15),
      ),
    );
  }
}
