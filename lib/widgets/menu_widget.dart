import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:aarohan_app/services/auth_services.dart';
import 'package:aarohan_app/models/user.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aarohan_app/screens/coming_soon.dart';
import 'package:aarohan_app/resources/eurekoin.dart';
import 'package:aarohan_app/models/coming_soon.dart';
import 'package:sizer/sizer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';

//
class MenuWidget extends StatefulWidget {
  bool showBottomMenu;
  VoidCallback callback;
  MenuWidget(this.showBottomMenu, this.callback);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  int x = 0;
  int status = 1;
  bool isEurekoinRegistered = false;
  @override
  void initState() {
    super.initState();
  }

  getuser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    AuthService authService = AuthService();
    await authService.storeUser(_auth.currentUser);
  }

  // Future<bool> getEurekoinRegistered()async{
  //   final prefs = await SharedPreferences.getInstance();
  //   final bool registered = prefs.getBool('eurekoinregistered');
  //   return registered!=null?registered:false;
  // }

  @override
  Widget build(BuildContext context) {
    getuser();
    List<ComingItem> comingItems = Provider.of<List<ComingItem>>(context);
    Users users = null;
    if (Users.us != null) {
      setState(() {
        users = Users.us;
        // print(Users.us.email);
      });
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BackdropFilter(
      filter: (widget.showBottomMenu)
          ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
          : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: fromCssColor('#E2F5FF').withOpacity(0.2),
        ),
        width: width,
        height: height * 0.65 + 55,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: !widget.showBottomMenu,
                child: Center(
                  child: Text(
                    "MENU",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Mons',
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              InkWell(
                onTap: widget.callback,
                child: Container(
                  child: (widget.showBottomMenu)
                      ? Image.asset('assets/down.png')
                      : Image.asset('assets/up.png'),
                  height: 40,
                  width: 40,
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Visibility(
                visible: widget.showBottomMenu,
                child: Column(
                  children: [
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 27.0,
                              backgroundImage: (users.photoURL != null)
                                  ? NetworkImage(users.photoURL)
                                  : AssetImage('assets/profile1.png'),
                            ),
                            SizedBox(
                              width: width * 0.06,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (users.name != null) ? "${users.name}" : "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Staat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  (users.email != null) ? "${users.email}" : "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.2,
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "About Aarohan",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name != '/')
                                Navigator.popAndPushNamed(context, '/about');
                              else
                                Navigator.pushNamed(context, '/about');
                            },
                            child: Container(
                              child: Image.asset('assets/profile.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Logout",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name != '/')
                                Navigator.pop(context);

                              AuthService authService = AuthService();
                              authService.gSignOut();
                            },
                            child: Container(
                              child: Image.asset('assets/logout.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Center(
                      child: Text(
                        "UTILITIES",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontFamily: 'Bebas',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Sponsors",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name != '/')
                                Navigator.popAndPushNamed(context, '/sponsor');
                              else
                                Navigator.pushNamed(context, '/sponsor');
                            },
                            child: Container(
                              child: Image.asset('assets/hand.png'),
                              height: height * 0.06,
                              width: width * 0.12,
                            ),
                          ),
                        ),
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Eurekoin",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () async {
                              String status =
                                  await Eurekoin.isEurekoinUserRegistered();
                              if (status == "0") {
                                if (ModalRoute.of(context).settings.name != '/')
                                  Navigator.popAndPushNamed(
                                      context, '/eurekoin');
                                else
                                  Navigator.pushNamed(context, '/eurekoin');
                              } else {
                                if (ModalRoute.of(context).settings.name != '/')
                                  Navigator.popAndPushNamed(
                                      context, '/leaderboard');
                                else
                                  Navigator.pushNamed(context, '/leaderboard');
                              }
                            },
                            child: Container(
                              child: Image.asset('assets/eurekoin.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Timeline",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              print(ModalRoute.of(context).settings.name);
                              if (ModalRoute.of(context).settings.name != '/')
                                Navigator.popAndPushNamed(context, '/timeline');
                              else {
                                print("hello");
                                Navigator.pushNamed(context, '/timeline');
                              }
                            },
                            child: Container(
                              child: Image.asset('assets/timer.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Contact Us",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name != '/')
                                Navigator.popAndPushNamed(context, '/contact');
                              else
                                Navigator.pushNamed(context, '/contact');
                            },
                            child: Container(
                              child: Image.asset('assets/msg.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Prelims",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (comingItems.length != 0 &&
                                  comingItems[comingItems.indexWhere(
                                              (element) =>
                                                  element.title == 'Prelims')]
                                          .flag ==
                                      false) {
                                if (ModalRoute.of(context).settings.name != '/')
                                  Navigator.popAndPushNamed(
                                      context, '/prelims');
                                else
                                  Navigator.pushNamed(context, '/prelims');
                              } else {
                                if (ModalRoute.of(context).settings.name != '/')
                                  Navigator.popAndPushNamed(context, '/coming');
                                else
                                  Navigator.pushNamed(context, '/coming');
                              }
                            },
                            child: Container(
                              child: Image.asset('assets/prelims.png'),
                              height: height * 0.06,
                              width: width * 0.14,
                            ),
                          ),
                        ),
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Contributors",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name != '/')
                                Navigator.popAndPushNamed(
                                    context, '/contributor');
                              else
                                Navigator.pushNamed(context, '/contributor');
                            },
                            child: Container(
                              child: Image.asset('assets/list.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        "ATTRACTIONS",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontFamily: 'Bebas',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Game",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (ModalRoute.of(context).settings.name != '/')
                                Navigator.popAndPushNamed(context, '/game');
                              else
                                Navigator.pushNamed(context, '/game');
                            },
                            child: Container(
                              child: Image.asset('assets/game.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Surprise",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              Permission.camera.request().whenComplete(() {
                                if (comingItems.length != 0 &&
                                    comingItems[comingItems.indexWhere(
                                                (element) =>
                                                    element.title == 'AR')]
                                            .flag ==
                                        false) {
                                  if (ModalRoute.of(context).settings.name !=
                                      '/')
                                    Navigator.popAndPushNamed(context, '/ar');
                                  else
                                    Navigator.pushNamed(context, '/ar');
                                } else {
                                  if (ModalRoute.of(context).settings.name !=
                                      '/')
                                    Navigator.popAndPushNamed(
                                        context, '/coming');
                                  else
                                    Navigator.pushNamed(context, '/coming');
                                }
                              });
                            },
                            child: Container(
                              child: Image.asset(
                                'assets/ar.png',
                                fit: BoxFit.fill,
                              ),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                        Tooltip(
                          padding: EdgeInsets.zero,
                          height: 1.h,
                          message: "Journo Detective",
                          decoration: BoxDecoration(color: Colors.transparent),
                          textStyle: TextStyle(color: Colors.white),
                          child: InkWell(
                            onTap: () {
                              if (comingItems.length != 0 &&
                                  comingItems[comingItems.indexWhere(
                                              (element) =>
                                                  element.title ==
                                                  'Journo Detective')]
                                          .flag ==
                                      false) {
                                if (ModalRoute.of(context).settings.name != '/')
                                  Navigator.popAndPushNamed(context, '/journo');
                                else
                                  Navigator.pushNamed(context, '/journo');
                              } else {
                                if (ModalRoute.of(context).settings.name != '/')
                                  Navigator.popAndPushNamed(context, '/coming');
                                else
                                  Navigator.pushNamed(context, '/coming');
                              }
                            },
                            child: Container(
                              child: Image.asset('assets/journo.png'),
                              height: height * 0.06,
                              width: width * 0.11,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
