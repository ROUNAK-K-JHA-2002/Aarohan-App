import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:aarohan_app/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'dart:ui';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';
import 'package:aarohan_app/models/sponsor.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Sponsors extends StatefulWidget {
  @override
  _SponsorsState createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {
  bool showBottomMenu = false;
  @override
  Widget build(BuildContext context) {
    List<SponsorItem> sponsorItems = Provider.of<List<SponsorItem>>(context);
    int l = sponsorItems.length;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double threshold = 100;
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
                          pageName: "Sponsors",
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
                                  crossAxisCount: 2,
                                  mainAxisExtent: 22.h,
                                ),
                                itemBuilder: (BuildContext context, index) =>
                                    Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      8.sp, 10.sp, 8.sp, 10.sp),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.sp),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: fromCssColor('#E2F5FF')
                                            .withOpacity(0.4),
                                        border: Border.all(
                                            color: Colors.white, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(7.sp),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7.sp),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              sponsorItems[index].imageUrl,
                                          fit: BoxFit.fitWidth,
                                          errorWidget: (context, url, error) {
                                            print("Could not load content");
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7.sp),
                                              child: Image.asset(
                                                  "assets/placeholder.jpg",
                                                  fit: BoxFit.cover),
                                            );
                                          },
                                          placeholder: (context, url) =>
                                              ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7.sp),
                                            child: Image.asset(
                                                "assets/placeholder.jpg",

                                                // height: 60.h,width: 100.w,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
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
                    // BottomMenu()
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
