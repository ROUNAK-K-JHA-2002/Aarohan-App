import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

class BottomMenu extends StatefulWidget {
  final visibleBottomMenu;
  const BottomMenu({Key key, this.visibleBottomMenu}) : super(key: key);

  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  List<String> menuBarIconsUnSelected = [
    'assets/menuBarSettings0.png',
    'assets/menuBarPerson0.png',
    'assets/menuBarConsole0.png'
  ];
  List<String> menuBarIconsSelected = [
    'assets/menuBarSettings1.png',
    'assets/menuBarPerson1.png',
    'assets/menuBarConsole1.png'
  ];
  String settingIcon = 'assets/menuBarSettings0.png';
  String personIcon = 'assets/menuBarPerson0.png';
  String consoleIcon = 'assets/menuBarConsole0.png';
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2.h),
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 7.h,
          width: 90.w,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  settingIcon = menuBarIconsSelected[0];
                  personIcon = menuBarIconsUnSelected[1];
                  consoleIcon = menuBarIconsUnSelected[2];
                });
              },
              child: Image.asset(
                settingIcon,
                height: 4.h,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  personIcon = menuBarIconsSelected[1];
                  settingIcon = menuBarIconsUnSelected[0];
                  consoleIcon = menuBarIconsUnSelected[2];
                });
              },
              child: Image.asset(
                personIcon,
                height: 4.h,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  consoleIcon = menuBarIconsSelected[2];
                  settingIcon = menuBarIconsUnSelected[0];
                  personIcon = menuBarIconsUnSelected[1];
                });
              },
              child: Image.asset(
                consoleIcon,
                height: 4.h,
              ),
            ),
          ]),
        ));
  }
}
