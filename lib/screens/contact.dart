import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:aarohan_app/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
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
                        pageName: "Contact Us",
                      ),
                      Expanded(
                          child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 4.h, 3.w, 0),
                          child: Container(
                            // height: MediaQuery.of(context).size.height,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.73,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, index) =>
                                  Container(
                                margin: EdgeInsets.all(2.w),
                                padding: EdgeInsets.all(1.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.sp),
                                ),
                                child: Column(
                                  children: [
                                    Container(
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
                                          height: 15.h,
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
                                                topRight: Radius.circular(7.sp),
                                                topLeft: Radius.circular(7.sp)),
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
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.sp),
                                      // height: 9.h,
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
                                          Text(
                                            (contactItems == null ||
                                                    contactItems.length == 0)
                                                ? ''
                                                : '${contactItems[index].name.split('-')[0]}',
                                            textAlign: TextAlign.center,
                                            // overflow: TextOverflow.clip,
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Text(
                                            (contactItems == null ||
                                                    contactItems.length == 0)
                                                ? ''
                                                : '${contactItems[index].name.split('-')[1]}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
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
                              itemCount: l,
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
