import 'package:aarohan_app/services/googleapi_services.dart';
import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/models/user.dart';
import 'package:aarohan_app/models/event.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'package:aarohan_app/sliver_components/SABT.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class Event_Detail extends StatefulWidget {
  @override
  _Event_DetailState createState() => _Event_DetailState();
}

GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

bool checkCalendar(String eventName, List calendar) {
  for (var i = 0; i < calendar.length; i++) {
    if (calendar[i].toString() == eventName) return false;
  }
  return true;
}

class _Event_DetailState extends State<Event_Detail> {
  Map data = {};
  bool showBottomMenu = false;

  @override
  Widget build(BuildContext context) {
    Users users = Users.us;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    data = ModalRoute.of(context).settings.arguments;
    EventItem eventItem = data['eventItem'];
    bool vis = checkCalendar(eventItem.title, users.calendar);
    List<String> textsplit = eventItem.contact.split('-');
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Aarohan_bg.png"),
                  colorFilter: new ColorFilter.mode(
                      Color.fromARGB(177, 48, 17, 6), BlendMode.srcOver),
                  fit: BoxFit.fill),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 86.h,
                        // color: Colors.red,
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              leading: Container(
                                padding: EdgeInsets.fromLTRB(5.w, 1.h, 0, 0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.only(top: 5.h),
                                    child: CircleAvatar(
                                      // radius: 15,
                                      backgroundImage:
                                          AssetImage('assets/back.png'),
                                    ),
                                  ),
                                ),
                              ),
                              flexibleSpace: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: FlexibleSpaceBar(
                                  collapseMode: CollapseMode.pin,
                                  title: SABT(
                                      child: Container(
                                    width: 70.w,
                                    // margin: EdgeInsets.only(
                                    //   bottom: 2.h,
                                    // ),
                                    child: Text(
                                      "${eventItem.title}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          letterSpacing: 1.1,
                                          fontFamily: 'Mons',
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                                  background: Container(
                                      child: CachedNetworkImage(
                                    imageUrl: eventItem.imageUrl,
                                    width: 100.w,
                                    fit: BoxFit.cover,
                                    height: 60.h,
                                    errorWidget: (context, url, error) {
                                      print("Could not load content");
                                      return Image.asset(
                                          "assets/placeholder.jpg",
                                          height: 60.h,
                                          width: 100.w,
                                          fit: BoxFit.cover);
                                    },
                                    placeholder: (context, url) => Image.asset(
                                        "assets/placeholder.jpg",
                                        height: 60.h,
                                        width: 100.w,
                                        fit: BoxFit.cover),
                                  )),
                                ),
                              ),
                              pinned: true,
                              // floating: true,
                              expandedHeight: 40.h,
                              backgroundColor: Colors.transparent,
                              collapsedHeight: 8.5.h,
                            ),
                            SliverList(
                                delegate: SliverChildListDelegate([
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () async {},
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                4.w, 0, 0, 0),
                                            child: Container(
                                              height: 9.h,
                                              width: 43.w,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 8,
                                                        spreadRadius: 1)
                                                  ],
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.5),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp)),
                                              child: GestureDetector(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              4.w,
                                                              2.h,
                                                              2.w,
                                                              3.h),
                                                      child: Icon(
                                                          Icons.calendar_today,
                                                          size: 23.5.sp,
                                                          color: Colors.black),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              2.w,
                                                              2.h,
                                                              2.w,
                                                              1.8.h),
                                                      child: Text(
                                                          eventItem.date,
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontFamily:
                                                                  'Staat',
                                                              letterSpacing:
                                                                  1.1,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 4.w, 0),
                                          child: Container(
                                            height: 9.h,
                                            width: 43.w,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.white,
                                                      blurRadius: 8,
                                                      spreadRadius: 1)
                                                ],
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.5),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.sp)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      4.w, 2.h, 2.w, 3.h),
                                                  child: Icon(
                                                      Icons.workspaces_filled,
                                                      size: 30,
                                                      color: Colors.black),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      2.w, 2.h, 2.w, 1.8.h),
                                                  child: Text(
                                                      eventItem.category,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontFamily: 'Staat',
                                                          letterSpacing: 1.1,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 1.7.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            UrlLauncher.launch(
                                                "tel://${textsplit[0]}");
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                4.w, 0, 0, 0),
                                            child: Container(
                                              height: 9.h,
                                              width: 43.w,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 8,
                                                        spreadRadius: 1)
                                                  ],
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.5),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            1.w, 2.5.h, 0, 3.h),
                                                    child: Icon(Icons.call,
                                                        size: 27,
                                                        color: Colors.black),
                                                  ),
                                                  FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(0,
                                                              2.h, 2.w, 1.8.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(textsplit[0],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontFamily:
                                                                      'Staat',
                                                                  letterSpacing:
                                                                      1.1,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                          Text(textsplit[1],
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontFamily:
                                                                      'Staat',
                                                                  letterSpacing:
                                                                      1.1,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            UrlLauncher.launch(
                                                "${eventItem.link}");
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 4.w, 0),
                                            child: Container(
                                              height: 9.h,
                                              width: 43.w,
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.white,
                                                        blurRadius: 8,
                                                        spreadRadius: 1)
                                                  ],
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1.5),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp)),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            4.w, 2.h, 0, 3.h),
                                                    child: Icon(
                                                        Icons.open_in_new,
                                                        size: 30,
                                                        color: Colors.black),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(3.w,
                                                            1.5.h, 2.w, 1.8.h),
                                                    child: Text('Go to Event',
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily: 'Staat',
                                                            letterSpacing: 1.1,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(5.w, 3.h, 2.w, 0),
                                    child: Text(eventItem.title,
                                        style: TextStyle(
                                            fontSize: 21.5.sp,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1.1,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(5.w, 3.h, 7.w, 2.h),
                                    child: Text(eventItem.body,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontFamily: 'Poppins',
                                            letterSpacing: 1.1,
                                            fontWeight: FontWeight.w200)),
                                  )
                                ],
                              ),
                            ]))
                          ],
                        ),
                      ),
                    ],
                  ),
                  BottomMenu()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
