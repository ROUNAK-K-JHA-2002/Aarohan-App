import 'dart:ui';

import 'package:aarohan_app/widgets/menuItems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/coming_soon.dart';
import '../models/user.dart';
import '../services/auth_services.dart';

class BottomMenu extends StatefulWidget {
  final visibleBottomMenu;
  const BottomMenu({Key key, this.visibleBottomMenu}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  double sigmaX = 0;
  double sigmaY = 0;
  getuser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    AuthService authService = AuthService();
    await authService.storeUser(_auth.currentUser);
  }

  List<String> menuBarIconsUnSelected = [
    'assets/menuBarSettings0.png',
    'assets/menuBarPerson0.png',
    'assets/menuBarConsole0.png'
  ];
  List<String> menuBarIconsSelected = [
    'assets/menuBarSettings1.png',
    'assets/menuBarPerson1.png',
    'assets/menuBarConsole1.png'
  ];
  String settingIcon = 'assets/menuBarSettings0.png';
  String personIcon = 'assets/menuBarPerson0.png';
  String consoleIcon = 'assets/menuBarConsole0.png';
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

    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 2.h),
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 7.h,
              width: 90.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sigmaX = 5;
                          sigmaY = 5;
                          settingIcon = menuBarIconsSelected[0];
                          personIcon = menuBarIconsUnSelected[1];
                          consoleIcon = menuBarIconsUnSelected[2];
                        });

                        showBottomSheet(
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                color: Colors.transparent,
                                height: 100.h,
                                width: 100.w,
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent),
                                    )),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 10.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.red),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 55.h,
                                        width: 90.w,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 4.h),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 10.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: (users.photoURL !=
                                                              null)
                                                          ? Image.network(
                                                              users.photoURL,
                                                            )
                                                          : Image.asset(
                                                              'assets/profile1.png'),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          (users.name != null)
                                                              ? "${users.name}"
                                                              : "",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Staat',
                                                              fontSize: 3.h,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing:
                                                                  1.2),
                                                        ),
                                                        SizedBox(
                                                          height: 1,
                                                        ),
                                                        Text(
                                                          (users.email != null)
                                                              ? "${users.email}"
                                                              : "",
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  1.2,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w),
                                              child: Divider(
                                                thickness: 1.5,
                                                color: Colors.grey.shade600,
                                                height: 1.h,
                                              ),
                                            ),
                                            Container(
                                              height: 25.h,
                                              width: 90.w,
                                              child: Scrollbar(
                                                  thickness: 2.w,
                                                  radius: Radius.circular(15),
                                                  thumbVisibility: true,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        MenuItems(
                                                          leadingImage:
                                                              'assets/timer.png',
                                                          itemName: 'TimeLine',
                                                          routeName:
                                                              '/timeline',
                                                        ),
                                                        MenuItems(
                                                          leadingImage:
                                                              'assets/contactUsIcon.png',
                                                          itemName:
                                                              'Contact Us',
                                                          routeName: '/contact',
                                                        ),
                                                        MenuItems(
                                                          leadingImage:
                                                              'assets/AboutUs.png',
                                                          itemName: 'About Us',
                                                          routeName: '/about',
                                                        ),
                                                        MenuItems(
                                                          leadingImage:
                                                              'assets/contributors.png',
                                                          itemName:
                                                              'Contributors',
                                                          routeName:
                                                              '/contributor',
                                                        ),
                                                        MenuItems(
                                                          leadingImage:
                                                              'assets/contributors.png',
                                                          itemName: 'Sponsors',
                                                          routeName: '/sponsor',
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            MaterialButton(
                                              child: Image.asset(
                                                'assets/arrow_down.png',
                                                height: 2.h,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  sigmaX = 0;
                                                  sigmaY = 0;
                                                  settingIcon =
                                                      menuBarIconsUnSelected[0];
                                                  personIcon =
                                                      menuBarIconsUnSelected[1];
                                                  consoleIcon =
                                                      menuBarIconsUnSelected[2];
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Image.asset(
                        settingIcon,
                        height: 4.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sigmaX = 5;
                          sigmaY = 5;
                          personIcon = menuBarIconsSelected[1];
                          settingIcon = menuBarIconsUnSelected[0];
                          consoleIcon = menuBarIconsUnSelected[2];

                          showBottomSheet(
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: Colors.transparent,
                                  height: 100.h,
                                  width: 100.w,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent),
                                      )),
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border:
                                                  Border.all(color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 50.h,
                                          width: 90.w,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4.h),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 8.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: (users
                                                                    .photoURL !=
                                                                null)
                                                            ? Image.network(
                                                                users.photoURL,
                                                              )
                                                            : Image.asset(
                                                                'assets/profile1.png'),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            (users.name != null)
                                                                ? "${users.name}"
                                                                : "",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Staat',
                                                                fontSize: 3.h,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    1.2),
                                                          ),
                                                          SizedBox(
                                                            height: 1,
                                                          ),
                                                          Text(
                                                            (users.email !=
                                                                    null)
                                                                ? "${users.email}"
                                                                : "",
                                                            style: TextStyle(
                                                                letterSpacing:
                                                                    1.2,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                child: Divider(
                                                  thickness: 1.5,
                                                  color: Colors.grey.shade600,
                                                  height: 1.h,
                                                ),
                                              ),
                                              Container(
                                                height: 25.h,
                                                width: 90.w,
                                                child: Scrollbar(
                                                    thickness: 2.w,
                                                    radius: Radius.circular(15),
                                                    thumbVisibility: true,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          MenuItems(
                                                            leadingImage:
                                                                'assets/eurekoin.png',
                                                            itemName:
                                                                'Eurekoin',
                                                            routeName:
                                                                '/eurekoin',
                                                          ),
                                                          MenuItems(
                                                            leadingImage:
                                                                'assets/appExitIcon.png',
                                                            itemName: 'Log Out',
                                                            routeName:
                                                                '/logout',
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              MaterialButton(
                                                child: Image.asset(
                                                    'assets/arrow_down.png'),
                                                onPressed: () {
                                                  setState(() {
                                                    sigmaX = 0;
                                                    sigmaY = 0;
                                                    settingIcon =
                                                        menuBarIconsUnSelected[
                                                            0];
                                                    personIcon =
                                                        menuBarIconsUnSelected[
                                                            1];
                                                    consoleIcon =
                                                        menuBarIconsUnSelected[
                                                            2];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                );
                              });
                        });
                      },
                      child: Image.asset(
                        personIcon,
                        height: 4.h,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          sigmaX = 5;
                          sigmaY = 5;
                          consoleIcon = menuBarIconsSelected[2];
                          settingIcon = menuBarIconsUnSelected[0];
                          personIcon = menuBarIconsUnSelected[1];

                          showBottomSheet(
                              backgroundColor: Colors.transparent,
                              enableDrag: false,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  color: Colors.transparent,
                                  height: 100.h,
                                  width: 100.w,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent),
                                      )),
                                      Container(
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border:
                                                  Border.all(color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: 50.h,
                                          width: 90.w,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 4.h),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: 8.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: (users
                                                                    .photoURL !=
                                                                null)
                                                            ? Image.network(
                                                                users.photoURL,
                                                              )
                                                            : Image.asset(
                                                                'assets/profile1.png'),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            (users.name != null)
                                                                ? "${users.name}"
                                                                : "",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Staat',
                                                                fontSize: 3.h,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    1.2),
                                                          ),
                                                          SizedBox(
                                                            height: 1,
                                                          ),
                                                          Text(
                                                            (users.email !=
                                                                    null)
                                                                ? "${users.email}"
                                                                : "",
                                                            style: TextStyle(
                                                                letterSpacing:
                                                                    1.2,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w),
                                                child: Divider(
                                                  thickness: 1.5,
                                                  color: Colors.grey.shade600,
                                                  height: 1.h,
                                                ),
                                              ),
                                              Container(
                                                height: 25.h,
                                                width: 90.w,
                                                child: Scrollbar(
                                                    thickness: 2.w,
                                                    radius: Radius.circular(15),
                                                    thumbVisibility: true,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          // MenuItems(
                                                          //   leadingImage:
                                                          //       'assets/leaderboard.png',
                                                          //   itemName:
                                                          //       'Leaderboard',
                                                          //   routeName:
                                                          //       '/leaderboard',
                                                          // ),
                                                          MenuItems(
                                                            leadingImage:
                                                                'assets/game.png',
                                                            itemName: 'Games',
                                                            routeName: '/game',
                                                          ),
                                                          // MenuItems(
                                                          //   leadingImage:
                                                          //       'assets/list.png',
                                                          //   itemName:
                                                          //       'Surprise',
                                                          //   routeName: '/about',
                                                          // ),
                                                          MenuItems(
                                                            leadingImage:
                                                                'assets/journo.png',
                                                            itemName:
                                                                'Journo Detective',
                                                            routeName:
                                                                '/journo',
                                                          ),
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                              MaterialButton(
                                                child: Image.asset(
                                                    'assets/arrow_down.png'),
                                                onPressed: () {
                                                  setState(() {
                                                    sigmaX = 0;
                                                    sigmaY = 0;
                                                    settingIcon =
                                                        menuBarIconsUnSelected[
                                                            0];
                                                    personIcon =
                                                        menuBarIconsUnSelected[
                                                            1];
                                                    consoleIcon =
                                                        menuBarIconsUnSelected[
                                                            2];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                );
                              });
                        });
                      },
                      child: Image.asset(
                        consoleIcon,
                        height: 4.h,
                      ),
                    ),
                  ]),
            )));
  }
}
