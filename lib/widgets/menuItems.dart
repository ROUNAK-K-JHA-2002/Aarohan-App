import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:googleapis/adsense/v2.dart';
import 'package:googleapis/bigquery/v2.dart';
import 'package:googleapis/content/v2_1.dart';
import 'package:sizer/sizer.dart';

import '../services/auth_services.dart';

class MenuItems extends StatefulWidget {
  final String leadingImage;
  final String itemName;
  final String routeName;
  const MenuItems({Key key, this.leadingImage, this.itemName, this.routeName})
      : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
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
            } else {
              Navigator.pushNamed(context, widget.routeName);
            }
          },
          child: Stack(children: [
            Container(
              width: 12.w,
              // padding: EdgeInsets.symmetric(vertical: 2.h),
              margin: EdgeInsets.only(left: 5.w),
              child: Image.asset(
                widget.leadingImage,
                fit: BoxFit.contain,
                height: 5.h,
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
