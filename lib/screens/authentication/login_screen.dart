import 'package:flash_chat/utilities/constants.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*
import 'package:flutter_screenutil/flutter_screenutil.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
      width: 14,
      height: 14,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black)),
      child: isSelected
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            )
          : Container());
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff013243),
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //Profile Pic / Logo
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
                    child: Image.asset(
                      "assets/ecowealth.png",
                      width: 125,
                      height: 250,
                    ),
                  ),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Color(0xfff0ead6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 10.0),
                        blurRadius: (10.0),
                      ),
                    ],
                  ),
                ),
              ),
              //end of Profile Picture(?)
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 0.0, bottom: 28.0),
                  child: Center(
                    child: Column(
                      //Login Infos
                      children: <Widget>[
                        Center(
                          child: Text(
                            'EcoWealth',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(80),
                            ),
                          ),
                        ),

                        //box for logins
                        Container(
                          width: double.infinity,
                          height: ScreenUtil.getInstance().setHeight(400),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 10.0),
                                blurRadius: (5.0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(50),
                                      fontFamily: "Poppins-Bold",
                                      letterSpacing: .6),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(30),
                                ),
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(28),
                                  ),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    hintText: 'username',
                                    hintStyle: TextStyle(
                                        fontFamily: "Roboto-Bold",
                                        color: Colors.grey,
                                        fontSize: 12.0),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      ScreenUtil.getInstance().setHeight(10),
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize:
                                        ScreenUtil.getInstance().setSp(28),
                                  ),
                                ),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(
                                        fontFamily: "Roboto-Bold",
                                        color: Colors.grey,
                                        fontSize: 12.0),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 3, top: 13, bottom: 0),
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: _radio,
                                          child: radioButton(_isSelected),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text("Remember me",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily:
                                                      "Poppins-Medium")),
                                        )
                                      ],
                                    ))
                              ],
                              //end of rows in column
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(425),
                        height: ScreenUtil.getInstance().setHeight(75),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(75.0 / 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 10.0),
                                blurRadius: 10.0,
                              )
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          //the sign-in with Google button
                          child: InkWell(
                            //do something when pressed
                            onTap: () {},
                            child: Center(
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 18, right: 10),
                                    child: Image(
                                        image: AssetImage(
                                            "assets/google_logo.png"),
                                        height: 33.0),
                                  ),
                                  Text(
                                    "Sign in with Google",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 16.25,
                                        letterSpacing: 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(200),
                        height: ScreenUtil.getInstance().setHeight(75),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(75.0/2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 10.0),
                                blurRadius: 10.0,
                              )
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          //the sign-in button
                          child: InkWell(
                            //do something when pressed
                            onTap: () {},
                            child: Center(
                              child: Text("Sign In",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 20,
                                      letterSpacing: .5)),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
        overflow: Overflow.visible,
      ),
    );
  }
}
*/