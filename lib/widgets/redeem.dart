import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:aarohan_app/services/auth_services.dart';
import 'package:aarohan_app/models/user.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';


class Redeem extends StatefulWidget {
  bool showdialog;
  Redeem(this.showdialog);

  @override
  _RedeemState createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {
  TextEditingController editingController = TextEditingController();
  @override
  getuser()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    AuthService authService = AuthService();
    await authService.storeUser(_auth.currentUser);
  }


  @override
  Widget build(BuildContext context) {
    // getuser();
    Users users = null;
    if(Users.us!=null){
      setState(() {
        users = Users.us;

      });
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return BackdropFilter(
      filter: (widget.showdialog)?ImageFilter.blur(sigmaX: 10,sigmaY: 10):ImageFilter.blur(sigmaX: 0,sigmaY: 0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: fromCssColor('#E2F5FF')
              .withOpacity(0.2),
        ),
        width: width,
        height: height*0.65 + 55,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 3.h,),
              Visibility(
                visible: widget.showdialog  ,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding:  EdgeInsets.fromLTRB(0, 0, 2.w, 0),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                widget.showdialog = false;
                                Navigator.pop(context);
                              });
                            },
                            child: Column(
                              children: [
                                Icon(Icons.cancel,size: 25.sp,color: Colors.white,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Text("Redeem Eurekoins",
                  style: TextStyle(
                      color: Colors.white, letterSpacing: 0.5,
                      fontFamily: 'Staat',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500),
                       ),
                    SizedBox(height: 4.h,),
                    Container(
                      width: 75.w,
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
                              contentPadding: EdgeInsets.fromLTRB(4.w, 1.h, 3.w, 1.h),
                              border: InputBorder.none,
                              labelText: 'Enter Redeem Code',
                              labelStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                          //
                        ),
                      ),
                    ),

                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}