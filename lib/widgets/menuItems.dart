import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';

import 'package:sizer/sizer.dart';

import '../resources/eurekoin.dart';
import '../services/auth_services.dart';

class MenuItems extends StatefulWidget {
  final dynamic leadingImage;
  final String itemName;
  final String routeName;
  const MenuItems({Key key, this.leadingImage, this.itemName, this.routeName})
      : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  void getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Location Permision Denied");
      LocationPermission askPermission = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("Longi" + currentPosition.longitude.toString());
      print("Latit" + currentPosition.latitude.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        height: 7.h,
        width: 90.w,
        child: InkWell(
          onTap: () {
            if (widget.routeName == '/logout') {
              Navigator.pop(context);
              AuthService authService = AuthService();
              authService.gSignOut();
              Navigator.pushReplacementNamed(context, '/login');
            } else if (widget.routeName == '/journo') {
              getLocation();
              Navigator.pushNamed(context, widget.routeName);
            } else if (widget.routeName == '/eurekoin') {
              Eurekoin.isEurekoinUserRegistered().then((value) {
                if (value == "0") {
                  Navigator.pushNamed(context, '/leaderboard');
                } else {
                  Navigator.pushNamed(context, widget.routeName);
                }
              });
            } else {
              Navigator.pushNamed(context, widget.routeName);
            }
          },
          child: Stack(children: [
            Container(
              width: 12.w,
              // padding: EdgeInsets.symmetric(vertical: 2.h),
              margin: EdgeInsets.only(left: 5.w),
              child: widget.leadingImage.runtimeType == String
                  ? Image.asset(
                      widget.leadingImage,
                      fit: BoxFit.contain,
                      height: 5.h,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(vertical: 4.sp),
                      child: Icon(
                        widget.leadingImage,
                        size: 30.sp,
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
              margin: EdgeInsets.only(left: 20.w),
              height: 6.h,
              child: Text(
                widget.itemName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 3.h,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Bebas'),
              ),
            )
          ]),
        ));
  }
}
