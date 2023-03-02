import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class topBar extends StatefulWidget {
  final String pageName;
  final String rightImage;
  final String leftImage;
  const topBar({Key key, this.pageName, this.rightImage, this.leftImage})
      : super(key: key);

  @override
  State<topBar> createState() => _topBarState();
}

class _topBarState extends State<topBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.5.w),
      alignment: Alignment.bottomCenter,
      height: 8.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/back.png'),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 1.h, left: 5.w),
                child: Text(
                  widget.pageName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Mons',
                      fontSize: 4.h,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SizedBox(
              width: 7.w,
              child: widget.rightImage == null
                  ? Text("")
                  : Image.asset(widget.rightImage),
            )
          ],
        ),
      ),
    );
  }
}
