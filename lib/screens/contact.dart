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
    double height= MediaQuery.of(context).size.height;  double width= MediaQuery.of(context).size.width;double threshold = 100;
    return Sizer(
      builder: (context,orientation,deviceType){
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
                onSwipeUp: (){
                  this.setState((){
                    showBottomMenu = true;
                  });
                },
                onSwipeDown: (){
                  this.setState((){
                    showBottomMenu = false;
                  });
                },
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          height: 13.5.h,
                          decoration: BoxDecoration(
                              color: fromCssColor('#E2F5FF')
                                  .withOpacity(0.4),
                              border: Border(bottom: BorderSide(
                                  color: Colors.white70,
                                  width: 1,
                                  style: BorderStyle.solid
                              ))
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5.w, 1.h, 0, 0),
                                    child: InkWell(
                                      onTap: (){
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
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(19.w, 0, 0, 0),
                                    child: Text(
                                      "Contact Us",
                                      style: TextStyle(
                                          color: Colors.white, letterSpacing: 1.1,
                                          fontFamily: 'Mons',
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 70.h,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(3.w, 4.h, 3.w, 0),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  // childAspectRatio: 0.75,
                                  crossAxisCount: 2,mainAxisExtent: 30.h,),
                                itemBuilder: (BuildContext context, index) => Padding(
                                  padding: EdgeInsets.all(4.sp),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 1),
                                      borderRadius: BorderRadius.circular(7.sp),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width: 45.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(7.sp),topLeft:Radius.circular(7.sp) ),

                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(7.sp),topLeft:Radius.circular(7.sp) ),
                                            child: CachedNetworkImage(imageUrl: contactItems[index].imageUrl, fit: BoxFit.cover,
                                              height: 20.h,
                                              width: 45.w,
                                              errorWidget: (context, url, error) {
                                                print("Could not load content");
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(7.sp),topLeft:Radius.circular(7.sp) ),

                                                  child: Image.asset("assets/placeholder.jpg",

                                                      height: 20.h,
                                                      width: 45.w,
                                                      fit: BoxFit.cover),
                                                );
                                              },
                                              placeholder: (context, url) => ClipRRect(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(7.sp),topLeft:Radius.circular(7.sp) ),
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
                                            color:
                                            fromCssColor('#E2F5FF').withOpacity(0.4),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: 0.5.h,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 5.w,),
                                                  Text(
                                                    (contactItems==null || contactItems.length==0)?'':'${contactItems[index].name}',
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w400,),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 0.5.h,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  // SizedBox(width: 2.w,),
                                                  InkWell(
                                                    onTap: (){
                                                      UrlLauncher.launch(
                                                          "tel://${contactItems[index].phone}");
                                                    },
                                                      child: Container(child: Icon(Icons.phone,color: Colors.white,))),
                                                  // SizedBox(width: 1.5.w,),

                                                  // SizedBox(width: 1.5.w,),
                                                  InkWell(
                                                    onTap: (){
                                                      UrlLauncher.launch(
                                                          "${contactItems[index].facebook}");
                                                    },
                                                    child: Container(
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/fb.png'),height: 3.h,),
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
                    AnimatedPositioned(
                        curve: Curves.easeInOut,
                        width: width,
                        duration: Duration(milliseconds: 500),
                        bottom: (showBottomMenu)?height*0.125:-(height*0.65),
                        child: CustomGestureDetector(
                            axis: CustomGestureDetector.AXIS_Y,
                            velocity: threshold,

                            onSwipeUp: (){
                              this.setState((){
                                showBottomMenu = true;
                              });
                            },
                            onSwipeDown: (){
                              this.setState((){
                                showBottomMenu = false;
                              });
                            },
                            child: MenuWidget(showBottomMenu,(){
                              setState(() {
                                showBottomMenu=!showBottomMenu;
                              });
                            })))
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