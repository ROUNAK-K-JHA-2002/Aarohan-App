import 'package:aarohan_app/widgets/custom_gesture_detector.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:aarohan_app/widgets/menu_widget.dart';
import 'package:flutter/services.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool showBottomMenu = false;
  
  @override
  Widget build(BuildContext context) {
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
                                       "About Aarohan",
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
                         SizedBox(
                           height: 3.h,
                         ),
                         Padding(
                           padding: EdgeInsets.fromLTRB(5.w, 0 , 4.w, 0),
                           child: Container(
                             height: 69.h,
                             // color: Colors.red,
                             child: ListView(
                               children: [
                                 Text(
                                   "The National Institute of Technology, Durgapur has been a premier educational institute nurturing students who have achieved par excellence in the field ofacademics and extra-curricular activities.\nAarohan is the Annual Techno-management fest of NIT Durgapur, the 2nd Largest of its kind in the whole of eastern India. Organised by Team Aavishkar,comprising the five biggest technical clubs of NIT Durgapur, this festival hasnever failed to uphold the banner of talent, innovation and a sense of responsibility.\nWith more than 50 events on varied domains, Aarohan is the biggest platform of our college that inculcates a sense of knowledge, science and technology- the building blocks for the future pillars of our nation.",
                                   style: TextStyle(
                                       color: Colors.white, letterSpacing: 1.1,
                                       fontFamily: 'Poppins',
                                       fontSize: 13.sp,
                                       fontWeight: FontWeight.w400),
                                 ),
                               ],
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