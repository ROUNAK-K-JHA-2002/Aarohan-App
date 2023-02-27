import 'package:flutter/material.dart';
import 'package:aarohan_app/resources/eurekoin.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';


class Eurekoin_Home extends StatefulWidget {


  @override
  _Eurekoin_HomeState createState() => _Eurekoin_HomeState();
}

class _Eurekoin_HomeState extends State<Eurekoin_Home> {
  TextEditingController editingController = TextEditingController();

  void setEurekoinRegistered()async{
    final prefs = await SharedPreferences.getInstance();
   await prefs.setBool('eurekoinregistered',true );
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Aarohan_bg.png"), fit: BoxFit.fill),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // resizeToAvoidBottomInset: false,
          body: Column(

            mainAxisAlignment:MainAxisAlignment.spaceBetween ,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Image.asset('assets/eurekoin.png',height: 35.h,),
              ),
              SizedBox(height: 5.h,),
              Column(
                children: [
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3,sigmaY: 3),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.w,),
                        decoration: BoxDecoration(
                          // color: Colors.red,
                            border: Border.all(color: Colors.white,width: 0.5.sp),
                            borderRadius: BorderRadius.circular(10.sp)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: TextField(
                            style:TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,letterSpacing: 1

                            ) ,
                            controller: editingController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(4.w, 0.5.h, 3.w, 0.5.h),
                                border: InputBorder.none,
                                labelText: 'Referral Code',
                                labelStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontFamily: 'Poppins',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500
                                )
                            ),
                            //
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.5.h,),
                  InkWell(
                    onTap: ()async{
                      await  Eurekoin.registerEurekoinUser(editingController.text);
                      await setEurekoinRegistered();
                      Navigator.popAndPushNamed(context, '/leaderboard');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 0.5.h),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          border: Border.all(color: Colors.white,width: 0.5.sp),
                          borderRadius: BorderRadius.circular(10.sp)
                      ),
                      child: Text("REGISTER",style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500
                      ),),

                    ),
                  ),
                  SizedBox(height: 2.h,)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
