import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:aarohan_app/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'dart:ui';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';
import 'package:aarohan_app/models/contact_us.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:cached_network_image/cached_network_image.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool showBottomMenu = false;
  @override
  Widget build(BuildContext context) {
    List<ContactItem> contactItems = Provider.of<List<ContactItem>>(context);
    int l = contactItems.length;
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
              body: Stack(
                children: [
                  Column(
                    children: [
                      topBar(
                        pageName: "Contact",
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
                                            imageUrl:
                                                contactItems[index].imageUrl,
                                            fit: BoxFit.cover,
                                            height: 20.h,
                                            width: 45.w,
                                            errorWidget: (context, url, error) {
                                              print("Could not load content");
                                              return ClipRRect(
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

                                        // child: Image(
                                        //     image: AssetImage(
                                        //         'assets/baby_enderman.png'),
                                        //     fit: BoxFit.fitWidth,height: 20.h,)
                                        // child: FittedBox(
                                        //   fit: BoxFit.fill,
                                        //   child: Image.asset(
                                        //       'assets/baby_enderman.png'),
                                        // ),
                                      ),
                                      Container(
                                        height: 8.2.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              bottomRight: Radius.circular(8)),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  (contactItems == null ||
                                                          contactItems.length ==
                                                              0)
                                                      ? ''
                                                      : '${contactItems[index].name}',
                                                  textAlign: TextAlign.center,
                                                  // overflow: TextOverflow.clip,
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // SizedBox(width: 2.w,),
                                                InkWell(
                                                    onTap: () {
                                                      UrlLauncher.launch(
                                                          "tel://${contactItems[index].phone}");
                                                    },
                                                    child: Container(
                                                        child: Icon(
                                                      Icons.phone,
                                                      color: Colors.black,
                                                    ))),
                                                // SizedBox(width: 1.5.w,),

                                                // SizedBox(width: 1.5.w,),
                                                InkWell(
                                                  onTap: () {
                                                    UrlLauncher.launch(
                                                        "${contactItems[index].facebook}");
                                                  },
                                                  child: Container(
                                                    child: Image(
                                                      image: AssetImage(
                                                          'assets/fb.png'),
                                                      height: 3.h,
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
        );
      },
    );
  }
}
