import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Coming extends StatefulWidget {


  @override
  _ComingState createState() => _ComingState();
}

class _ComingState extends State<Coming> {
  @override
  Widget build(BuildContext context) {
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
              body: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("COMING",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1.1,
                                fontFamily: 'Staat',
                                fontSize: 56.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text("SOON",
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1.1,
                                fontFamily: 'Staat',
                                fontSize: 56.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top:2.h ,
                      left: 5.w,
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
              ),
            ),
        );
      },
    );
  }
}
