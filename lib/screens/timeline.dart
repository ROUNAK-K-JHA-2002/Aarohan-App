import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:aarohan_app/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aarohan_app/models/schedule.dart';
import 'package:aarohan_app/services/sort_timeline.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:aarohan_app/widgets/timeline_list.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  Map<String, List> M = {};
  bool showBottomMenu = false;
  String day = "3rd";
  int x = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    List<DayItem> dayItems = Provider.of<List<DayItem>>(context);
    Sort_Events sort = Sort_Events();
    setState(() {
      if (x == 0 && dayItems.length != 0) {
        M = sort.func(dayItems[0].events);
        x++;
        print(dayItems);
      }
    });

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
              body: CustomGestureDetector(
                axis: CustomGestureDetector.AXIS_Y,
                velocity: threshold,
                onSwipeUp: () {
                  this.setState(() {
                    showBottomMenu = true;
                  });
                },
                onSwipeDown: () {
                  this.setState(() {
                    showBottomMenu = false;
                  });
                },
                onTap: null,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        topBar(
                          pageName: "Timeline",
                        ),
                        Container(
                          height: 6.h,
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    day = "3rd";
                                    M = {};
                                    M = sort.func(dayItems[0].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  height: 8.h,
                                  width: 24.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "3",
                                        style: TextStyle(
                                            color: (day == "3rd")
                                                ? Color.fromRGBO(232, 94, 86, 1)
                                                : Colors.black,
                                            fontFamily: 'Staat',
                                            fontSize: 4.5.w,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 3.5),
                                      Visibility(
                                        visible: (day == "3rd"),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  232, 94, 86, 1),
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
                                    day = "4th";
                                    M = {};
                                    M = sort.func(dayItems[0].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  height: 8.h,
                                  width: 24.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "4",
                                        style: TextStyle(
                                            color: (day == "4th")
                                                ? Color.fromRGBO(232, 94, 86, 1)
                                                : Colors.black,
                                            fontFamily: 'Staat',
                                            fontSize: 4.5.w,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 3.5),
                                      Visibility(
                                        visible: (day == "4th"),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  232, 94, 86, 1),
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
                                    day = "5th";
                                    M = {};
                                    M = sort.func(dayItems[0].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  height: 8.h,
                                  width: 24.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "5",
                                        style: TextStyle(
                                            color: (day == "5th")
                                                ? Color.fromRGBO(232, 94, 86, 1)
                                                : Colors.black,
                                            fontFamily: 'Staat',
                                            fontSize: 4.5.w,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 3.5),
                                      Visibility(
                                        visible: (day == "5th"),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  232, 94, 86, 1),
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
                                    day = "6th";
                                    M = {};
                                    M = sort.func(dayItems[0].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  height: 8.h,
                                  width: 24.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "6",
                                        style: TextStyle(
                                            color: (day == "6th")
                                                ? Color.fromRGBO(232, 94, 86, 1)
                                                : Colors.black,
                                            fontFamily: 'Staat',
                                            fontSize: 4.5.w,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 3.5),
                                      Visibility(
                                        visible: (day == "6th"),
                                        child: Container(
                                          height: 5,
                                          width: 5,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  232, 94, 86, 1),
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
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 3.h),
                            height: 59.h,
                            // color: Colors.red,
                            child: (M.length != 0)
                                ? ListView.builder(
                                    itemCount: M.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(8.w, 0, 0, 2.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.circle_outlined,
                                                  color: Colors.white,
                                                  size: 10.sp,
                                                ),
                                                SizedBox(
                                                  width: 2.5.w,
                                                ),
                                                Text(
                                                  "${M.keys.elementAt(index)}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Gugi',
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Timeline_List(
                                                M[M.keys.elementAt(index)])
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
