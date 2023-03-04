import 'package:aarohan_app/widgets/bottomMenu.dart';
import 'package:aarohan_app/widgets/topBar.dart';
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
import 'package:url_launcher/url_launcher.dart';

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
                        pageName: "Contributors",
                      ),
                      Expanded(
                          child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 2.h, 3.w, 0),
                          child: Container(
                            // height: MediaQuery.of(context).size.height,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.75,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (BuildContext context, index) =>
                                  Container(
                                margin: EdgeInsets.all(3.sp),
                                padding: EdgeInsets.all(3.sp),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.sp),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: 13.h,
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
                                            height: 17.h,
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
                                      ),
                                      Container(
                                        // height: 8.2.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
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
                                                  MainAxisAlignment.spaceEvenly,
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
                                                    launchUrl(Uri(
                                                        scheme: 'mailto',
                                                        path:
                                                            "${contributorItems[index].email}"));
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
