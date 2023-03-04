import 'package:aarohan_app/screens/loader_screen.dart';
import 'package:aarohan_app/services/auth_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'package:aarohan_app/models/event.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:aarohan_app/models/user.dart';
import 'dart:ui';
import 'package:aarohan_app/widgets/loader.dart';
import 'package:aarohan_app/screens/loader_screen.dart';

import '../widgets/bottomMenu.dart';

class Dashboard extends StatefulWidget {
  bool isIntroDone = false;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  bool isLoading = false;
  String selectedcategory = "All";
  List<String> tags = [
    "Logic",
    "Strategy",
    "Mystery",
    "Innovation",
    "Treasure-Hunt",
    "Coding",
    "Sports",
    "Robotics",
    "Workshops",
    "Business"
  ];

  int x = 0;
  int selectedIndex;
  CarouselController buttonCarouselController = CarouselController();
  BottomDrawerController controller = BottomDrawerController();
  List<EventItem> arr = [];
  List<EventItem> _foundUsers = [];
  String day = "";
  // GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  bool showBottomMenu = false;
  bool search = false;
  List<EventItem> eventItems;

  bool visibleBottomMenu = false;

  void _runFilter(String enteredKeyword, List<EventItem> M) {
    List<EventItem> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = M;
    } else {
      results = M
          .where((user) =>
              user.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  void initState() {
    // at the beginning, all users are shown

    _foundUsers = eventItems;
    super.initState();
  }

  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    eventItems = Provider.of<List<EventItem>>(context);

    setState(() {
      if (x == 0 && eventItems.length != 0) {
        arr = eventItems;
        x++;
      }
    });
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    // print();

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Aarohan_bg.png"),
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Color.fromARGB(177, 48, 17, 6), BlendMode.srcOver),
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromARGB(39, 0, 0, 0),
            body: Stack(children: [
              Column(
                children: [
                  Visibility(
                    visible: search,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(3.w, 1.5.h, 3.w, 1.5.h),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 3.w,
                                ),
                                Container(
                                  width: 70.w,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.5.sp),
                                      borderRadius:
                                          BorderRadius.circular(10.sp)),
                                  child: Padding(
                                    padding: EdgeInsets.all(1.sp),
                                    child: TextField(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = -1;
                                          print(selectedIndex);
                                        });
                                      },
                                      style: TextStyle(
                                          fontFamily: 'Mons',
                                          fontSize: 13.sp,
                                          letterSpacing: 1),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedIndex = -1;
                                        });
                                        _runFilter(value, eventItems);
                                      },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10.sp),
                                          border: InputBorder.none,
                                          labelText: 'Search',
                                          labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Mons',
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500)),
                                      //
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        search = !search;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.cancel,
                                          size: 25.sp,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Container(
                              height: 4.h,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: tags.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        _foundUsers = eventItems
                                            .where((element) => (element.tag
                                                .contains(tags[index])))
                                            .toList();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: (selectedIndex == index)
                                              ? Color.fromARGB(255, 157, 11, 3)
                                              : Color.fromRGBO(232, 94, 86, 1),
                                          borderRadius:
                                              BorderRadius.circular(7.sp)),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 1.5.w),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Text(
                                        '${tags[index]}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !search,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 3.h, horizontal: 2.5.w),
                      alignment: Alignment.bottomCenter,
                      height: 8.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage('assets/aarohan-logo.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: Text(
                                "Aarohan",
                                style: TextStyle(
                                    fontFamily: 'Mons',
                                    fontSize: 5.h,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _foundUsers = eventItems;
                                });
                                setState(() {
                                  search = !search;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade700,
                                    border: Border.all(
                                        color: Colors.white70, width: 0.1.w),
                                    borderRadius: BorderRadius.circular(2.w)),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0.5.h),
                                  child: Image.asset('assets/search.png'),
                                ),
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !search,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      height: 6.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                arr = eventItems;
                                selectedcategory = "All";
                                day = "0";
                              });
                            },
                            child: Container(
                              height: 8.h,
                              width: 24.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ALL",
                                    style: TextStyle(
                                        color: (selectedcategory == "All")
                                            ? Color.fromRGBO(232, 94, 86, 1)
                                            : Colors.black,
                                        fontFamily: 'Staat',
                                        fontSize: 4.5.w,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 3.5),
                                  Visibility(
                                    visible: (selectedcategory == "All"),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(232, 94, 86, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                arr = eventItems
                                    .where((element) =>
                                        element.category == "Workshop")
                                    .toList();
                                selectedcategory = "Workshop";
                                day = "0";
                              });
                            },
                            child: Container(
                              height: 8.h,
                              width: 24.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "WORKSHOPS",
                                    style: TextStyle(
                                        color: (selectedcategory == "Workshop")
                                            ? Color.fromRGBO(232, 94, 86, 1)
                                            : Colors.black,
                                        fontFamily: 'Staat',
                                        fontSize: 4.5.w,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 3.5),
                                  Visibility(
                                    visible: (selectedcategory == "Workshop"),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(232, 94, 86, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                arr = eventItems
                                    .where((element) =>
                                        element.category == "Event")
                                    .toList();
                                selectedcategory = "Event";
                                day = "0";
                              });
                            },
                            child: Container(
                              height: 8.h,
                              width: 24.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "EVENTS",
                                    style: TextStyle(
                                        color: (selectedcategory == "Event")
                                            ? Color.fromRGBO(232, 94, 86, 1)
                                            : Colors.black,
                                        fontFamily: 'Staat',
                                        fontSize: 4.5.w,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 3.5),
                                  Visibility(
                                    visible: (selectedcategory == "Event"),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(232, 94, 86, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                arr = eventItems
                                    .where(
                                        (element) => element.category == "Talk")
                                    .toList();
                                selectedcategory = "Talk";
                                day = "0";
                              });
                            },
                            child: Container(
                              height: 8.h,
                              width: 24.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "TALKS",
                                    style: TextStyle(
                                        color: (selectedcategory == "Talk")
                                            ? Color.fromRGBO(232, 94, 86, 1)
                                            : Colors.black,
                                        fontFamily: 'Staat',
                                        fontSize: 4.5.w,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 3.5),
                                  Visibility(
                                    visible: (selectedcategory == "Talk"),
                                    child: Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(232, 94, 86, 1),
                                          shape: BoxShape.circle),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !search,
                    child: Container(
                        margin: EdgeInsets.only(top: 1.h),
                        height: 48.h,
                        child: (arr.length != 0)
                            ? CarouselSlider.builder(
                                itemCount: arr.length,
                                options: CarouselOptions(
                                  height: 56.h,
                                  aspectRatio: 1.15,
                                  viewportFraction: 0.72,
                                  initialPage: 0,
                                  enableInfiniteScroll: true,
                                  reverse: false,
                                  autoPlay: true,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                  enlargeCenterPage: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                                carouselController: buttonCarouselController,
                                itemBuilder: (BuildContext context, int index,
                                        int pageViewIndex) =>
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/eventpage',
                                                arguments: {
                                                  'eventItem': arr[index]
                                                });
                                          },
                                          child: Container(
                                            height: 40.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              child: CachedNetworkImage(
                                                // height: 100,
                                                // width: 120,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) {
                                                  print(
                                                      "Could not load content");
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                    child: Image.asset(
                                                        "assets/placeholder.jpg",
                                                        height: 40.h,
                                                        fit: BoxFit.cover),
                                                  );
                                                },
                                                placeholder: (context, url) =>
                                                    ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  child: Image.asset(
                                                      "assets/placeholder.jpg",
                                                      height: 40.h,
                                                      fit: BoxFit.cover),
                                                ),
                                                imageUrl: arr[index].imageUrl,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Text(
                                          "${arr[index].title}",
                                          style: TextStyle(
                                              fontFamily: 'Mons',
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15.sp,
                                              letterSpacing: 1.2),
                                        )
                                      ],
                                    ))
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                  ),
                  Visibility(
                    visible: search,
                    child: Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Container(
                        height: 68.h,
                        child: (_foundUsers != null && _foundUsers.isNotEmpty)
                            ? ListView.builder(
                                itemCount: _foundUsers.length,
                                itemBuilder: (context, index) => Container(
                                  height: 10.h,
                                  padding:
                                      EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.h),
                                  child: InkWell(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      Navigator.pushNamed(context, '/eventpage',
                                          arguments: {
                                            'eventItem': _foundUsers[index]
                                          });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 0.2.w),
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          color: Colors.white),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 23.w,
                                            width: 23.w,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.sp),
                                                  topLeft:
                                                      Radius.circular(10.sp)),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.sp),
                                                  topLeft:
                                                      Radius.circular(10.sp)),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    _foundUsers[index].imageUrl,
                                                width: 23.w,
                                                fit: BoxFit.cover,
                                                height: 23.w,
                                                errorWidget:
                                                    (context, url, error) {
                                                  print(
                                                      "Could not load content");
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.sp),
                                                            topLeft: Radius
                                                                .circular(
                                                                    10.sp)),
                                                    child: Image.asset(
                                                        "assets/placeholder.jpg",
                                                        height: 23.w,
                                                        width: 23.w,
                                                        fit: BoxFit.cover),
                                                  );
                                                },
                                                placeholder: (context, url) =>
                                                    ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15.sp),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15.sp)),
                                                  child: Image.asset(
                                                      "assets/placeholder.jpg",
                                                      height: 23.w,
                                                      width: 23.w,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  _foundUsers[index]
                                                      .title
                                                      .toString(),
                                                  overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Mons',
                                                      letterSpacing: 1.1,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.h),
                                child: Container(
                                  height: 8.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 0.2.w),
                                      borderRadius:
                                          BorderRadius.circular(15.sp),
                                      color: fromCssColor('#E2F5FF')
                                          .withOpacity(0.25)),
                                  child: Center(
                                    child: Text(
                                      'No results found',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Mons',
                                          letterSpacing: 1.1,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: !search,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        child: Text(
                          "Fest Dates",
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontFamily: 'Mons',
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                  // SizedBox(
                  //   height: 2.h,
                  // ),
                  Visibility(
                    visible: !search,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              day = "3rd";
                              selectedcategory = "";
                              arr = eventItems
                                  .where((element) =>
                                      (DateTime.parse(element.date).day == 3))
                                  .toList();
                            });
                          },
                          child: Container(
                            width: 12.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                                color: (day == "3rd")
                                    ? Colors.white70
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("9",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 3.h,
                                        fontWeight: FontWeight.w500)),
                                Text("Thu",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              day = "4th";
                              selectedcategory = "";
                              arr = eventItems
                                  .where((element) =>
                                      (DateTime.parse(element.date).day == 4))
                                  .toList();
                            });
                          },
                          child: Container(
                            width: 12.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                                color: (day == "4th")
                                    ? Colors.white70
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("10",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 3.h,
                                        fontWeight: FontWeight.w500)),
                                Text("Fri",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              day = "5th";
                              selectedcategory = "";
                              arr = eventItems
                                  .where((element) =>
                                      (DateTime.parse(element.date).day == 5))
                                  .toList();
                            });
                          },
                          child: Container(
                            width: 12.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                                color: (day == "5th")
                                    ? Colors.white70
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("11",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 3.h,
                                        fontWeight: FontWeight.w500)),
                                Text("Sat",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              day = "6th";
                              selectedcategory = "";
                              arr = eventItems
                                  .where((element) =>
                                      (DateTime.parse(element.date).day == 6))
                                  .toList();
                            });
                          },
                          child: Container(
                            width: 12.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                                color: (day == "6th")
                                    ? Colors.white70
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5.sp)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("12",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 3.h,
                                        fontWeight: FontWeight.w500)),
                                Text("Sun",
                                    style: TextStyle(
                                        fontFamily: 'Mons',
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              BottomMenu()
            ]),
          ),
        ),
      );
    });
  }
}
