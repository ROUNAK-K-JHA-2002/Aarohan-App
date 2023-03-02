import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:from_css_color/from_css_color.dart';
import 'dart:ui';

class Timeline_List extends StatelessWidget {
  Timeline_List(this.data);
  List data;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ClipRect(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 1..w),
        // color: Colors.white,
        height: 10.h * data.length,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: 1.w,
                ),
                Container(
                  child: Image.asset('assets/line.png'),
                  height: 10.h,
                  width: width * 0.01,
                ),
                SizedBox(
                  width: 2.w,
                ),
                ClipRRect(
                  borderRadius: (index == data.length - 1)
                      ? BorderRadius.only(bottomLeft: Radius.circular(15.sp))
                      : BorderRadius.circular(0),
                  child: Container(
                    width: width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                              color: Colors.white,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                    height: 10.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 1.5.h, 0, 0),
                          child: Text(
                            "${data[index]}",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12.5.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(3.w, 0.4.h, 0, 0),
                          child: Text(
                            "Online",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
