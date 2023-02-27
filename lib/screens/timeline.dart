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
  Map<String,List> M={};
  bool showBottomMenu = false; String day = "3rd"; int x=0;
  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;  double width= MediaQuery.of(context).size.width;double threshold = 100;
    List<DayItem> dayItems = Provider.of<List<DayItem>>(context);
    Sort_Events sort  =Sort_Events();
    setState(() {
      if(x==0 && dayItems.length!=0) {
        M = sort.func(dayItems[0].events);x++;
        print(dayItems);
      }
    });


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
              body:  CustomGestureDetector(
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
                                      "Timeline",
                                      style: TextStyle(
                                          color: Colors.white, letterSpacing: 1.1,
                                          fontFamily: 'Mons',
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 3.w, 0),
                                    child: Text(
                                      "${day} March",
                                      style: TextStyle(
                                          color: Colors.white, letterSpacing: 1.1,
                                          fontFamily: 'Mons',
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 10.5.h,
                          decoration: BoxDecoration(
                              color: fromCssColor('#E2F5FF')
                                  .withOpacity(0.18),
                              border: Border(bottom: BorderSide(
                                  color: Colors.white70,
                                  width: 0.5,
                                  style: BorderStyle.solid
                              ))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    day = "3rd";
                                    M = {};
                                    M = sort.func(dayItems[0].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  width: 12.w, height: 8.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white70, width: 0.5.sp
                                      ),
                                      color: (day=="3rd")?fromCssColor('#E2F5FF').withOpacity(0.4):fromCssColor('#E2F5FF').withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("3", style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                      SizedBox(height: 1.h,),
                                      Text("Thu",
                                          style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    day = "4th";
                                    M = {};
                                    M = sort.func(dayItems[1].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  width: 12.w, height: 8.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white70, width: 0.5.sp
                                      ),
                                      color: (day=="4th")?fromCssColor('#E2F5FF').withOpacity(0.4):fromCssColor('#E2F5FF').withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("4", style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                      SizedBox(height: 1.h,),
                                      Text("Fri",
                                          style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),            InkWell(
                                onTap: (){
                                  setState(() {
                                    day = "5th";
                                    M = {};
                                    M = sort.func(dayItems[2].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  width: 12.w, height: 8.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white70, width: 0.5.sp
                                      ),
                                      color: (day=="5th")?fromCssColor('#E2F5FF').withOpacity(0.4):fromCssColor('#E2F5FF').withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("5", style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                      SizedBox(height: 1.h,),
                                      Text("Sat",
                                          style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),            InkWell(
                                onTap: (){
                                  setState(() {
                                    day = "6th";
                                    M = {};
                                    M = sort.func(dayItems[3].events);
                                    print(M);
                                  });
                                },
                                child: Container(
                                  width: 12.w, height: 8.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white70, width: 0.5.sp
                                      ),
                                      color: (day=="6th")?fromCssColor('#E2F5FF').withOpacity(0.4):fromCssColor('#E2F5FF').withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5.sp)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("6", style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                      SizedBox(height: 1.h,),
                                      Text("Sun",
                                          style: TextStyle(color: Colors.white, fontFamily: 'Mons', fontSize: 11.sp, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Container(
                            height: 59.h,
                            // color: Colors.red,
                            child: (M.length!=0)?ListView.builder(
                              itemCount: M.length ,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(8.w, 0, 0, 2.h),
                                  child: Column(crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle, color: Colors.white,size: 10.sp,
                                          ),
                                          SizedBox(width: 2.5.w,),
                                          Text("${M.keys.elementAt(index)}",style: TextStyle(color: Colors.white,fontFamily: 'Gugi',
                                              fontSize: 15.sp, fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      SizedBox(height: 1.h,),
                                      Timeline_List(M[M.keys.elementAt(index)])

                                    ],),
                                );
                              },

                            ):Center(child: CircularProgressIndicator(),),
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