import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:googleapis/cloudtasks/v2.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/services/auth_services.dart';
import 'package:aarohan_app/repository/user_respository.dart';
import 'package:aarohan_app/resources/eurekoin.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: Stack(
            children: [
              Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/login-gif.gif"),
                        fit: BoxFit.fill),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage(
                              'assets/aarohan-logo 1.png',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('Aarohan',
                              style: TextStyle(
                                  fontFamily: 'Mons',
                                  fontSize: 60,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text('By Team Aavishkar',
                              style: TextStyle(
                                  fontFamily: 'Mons',
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        ),
                        GestureDetector(
                          onTap: () async {
                            AuthService authService = AuthService();
                            authService.gSignIn();

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Container(
                              width: 70.w,
                              height: 7.h,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    color: fromCssColor('#ff0000').withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10.sp)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 8, 0, 8),
                                      child: Image(
                                          image: AssetImage('assets/google.png')),
                                    ),
                                    Text('Sign In With Google', style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          )
        );
      },
    );
  }
}