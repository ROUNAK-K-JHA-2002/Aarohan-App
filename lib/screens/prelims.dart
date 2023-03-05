import 'package:aarohan_app/widgets/topBar.dart';
import 'package:flutter/material.dart';
import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:sizer/sizer.dart';
import 'package:aarohan_app/models/prelim.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Prelims extends StatefulWidget {
  @override
  _PrelimsState createState() => _PrelimsState();
}

class _PrelimsState extends State<Prelims> {
  bool showBottomMenu = false;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    List<PrelimItem> prelimItems = Provider.of<List<PrelimItem>>(context);
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
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  Column(
                    children: [
                      topBar(
                        pageName: "Prelims",
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        height: 65.h,
                        child: ListView.builder(
                          itemCount: prelimItems.length,
                          itemBuilder: (context, index) {
                            return ClipRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.h),
                                  child: InkWell(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus
                                          .unfocus();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SafeArea(
                                                    child: Scaffold(
                                                      body: InAppWebView(
                                                        initialUrlRequest:
                                                            URLRequest(
                                                                url: Uri.parse(
                                                                    "${prelimItems[index].url}")),
                                                        androidOnPermissionRequest:
                                                            (controller, origin,
                                                                resources) async {
                                                          return PermissionRequestResponse(
                                                              resources:
                                                                  resources,
                                                              action:
                                                                  PermissionRequestResponseAction
                                                                      .GRANT);
                                                        },
                                                        onProgressChanged:
                                                            (controller,
                                                                progress) {
                                                          setState(() {
                                                            this.progress =
                                                                progress / 100;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          color: Colors.white),
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            prelimItems[index].title.toString(),
                                            style: TextStyle(
                                                fontFamily: 'Mons',
                                                letterSpacing: 1.1,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        height: 8.h,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
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
