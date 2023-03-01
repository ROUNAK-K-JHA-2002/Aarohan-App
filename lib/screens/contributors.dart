import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/appengine/v1.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'dart:ui';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';
import 'package:aarohan_app/models/contributor.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:cached_network_image/cached_network_image.dart';

class Contributors extends StatefulWidget {
  @override
  _ContributorsState createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors> {
  bool showBottomMenu = false;
  @override
  Widget build(BuildContext context) {
    List<ContributorItem> contributorItems =
        Provider.of<List<ContributorItem>>(context);
    int l = contributorItems.length;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
    return Sizer(
      builder: (context, orientation, deviceType) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/Aarohan_bg.png"), fit: BoxFit.fill),
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
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
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
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundImage:
                                          AssetImage('assets/back.png'),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 1.h, left: 5.w),
                                    child: Text(
                                      "Contributors",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Mons',
                                          fontSize: 4.h,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 70.h,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(3.w, 4.h, 3.w, 0),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  // childAspectRatio: 0.75,
                                  crossAxisCount: 2, mainAxisExtent: 23.85.h,
                                ),
                                itemBuilder: (BuildContext context, index) =>
                                    Padding(
                                  padding: EdgeInsets.all(8.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(7.sp),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 13.h,
                                          width: 45.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(7.sp),
                                                topLeft: Radius.circular(7.sp)),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(7.sp),
                                                topLeft: Radius.circular(7.sp)),
                                            child: CachedNetworkImage(
                                              imageUrl: contributorItems[index]
                                                  .imageUrl,
                                              fit: BoxFit.cover,
                                              height: 20.h,
                                              width: 45.w,
                                              errorWidget:
                                                  (context, url, error) {
                                                print("Could not load content");
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  7.sp),
                                                          topLeft:
                                                              Radius.circular(
                                                                  7.sp)),
                                                  child: Image.asset(
                                                      "assets/placeholder.jpg",
                                                      height: 20.h,
                                                      width: 45.w,
                                                      fit: BoxFit.cover),
                                                );
                                              },
                                              placeholder: (context, url) =>
                                                  ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(7.sp),
                                                    topLeft:
                                                        Radius.circular(7.sp)),
                                                child: Image.asset(
                                                    "assets/placeholder.jpg",
                                                    height: 20.h,
                                                    width: 45.w,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 8.2.h,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8))),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    (contributorItems == null ||
                                                            contributorItems
                                                                    .length ==
                                                                0)
                                                        ? ''
                                                        : '${contributorItems[index].name}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ))
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        UrlLauncher.launch(
                                                            "tel://${contributorItems[index].phone}");
                                                      },
                                                      child: Container(
                                                          child: Icon(
                                                        Icons.phone,
                                                        color: Colors.black,
                                                        size: 2.5.h,
                                                      ))),
                                                  // SizedBox(width: 1.5.w,),
                                                  InkWell(
                                                    onTap: () {
                                                      UrlLauncher.launch(
                                                          "${contributorItems[index].linkedin}");
                                                    },
                                                    child: Container(
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/linkedin.png'),
                                                        height: 5.h,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(width: 1.5.w,),
                                                  InkWell(
                                                    onTap: () {
                                                      UrlLauncher.launch(
                                                          "${contributorItems[index].github}");
                                                    },
                                                    child: Container(
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/github.png'),
                                                        height: 2.5.h,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      UrlLauncher.launch(
                                                          "${contributorItems[index].github}");
                                                    },
                                                    child: Container(
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/google.png'),
                                                        height: 2.5.h,
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
                                itemCount: l,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    BottomMenu()
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
