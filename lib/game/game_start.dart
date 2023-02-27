import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'cactus.dart';
import 'cloud.dart';
import 'constants.dart';
import 'dino.dart';
import 'game-object.dart';
import 'ground.dart';
import 'package:sizer/sizer.dart';
import 'package:from_css_color/from_css_color.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Dino dino = Dino();   int x = 0;
  double runDistance = 0;
  double runVelocity = 30;

  AnimationController worldController;
  Duration lastUpdateCall = Duration();

  List<Cactus> cacti = [Cactus(worldLocation: Offset(200, 0))];

  List<Ground> ground = [
    Ground(worldLocation: Offset(0, 0)),
    Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
  ];

  List<Cloud> clouds = [
    Cloud(worldLocation: Offset(100, 20)),
    Cloud(worldLocation: Offset(200, 10)),
    Cloud(worldLocation: Offset(350, -10)),
  ];

  @override
  void initState() {
    super.initState();

    worldController =
        AnimationController(vsync: this, duration: Duration(days: 99));
    worldController.addListener(_update);
    worldController.forward();
  }

  void _die() {
    setState(() {
      worldController.stop();
      dino.die();
    });
  }

  _update() {
    dino.update(lastUpdateCall, worldController.lastElapsedDuration);

    double elapsedTimeSeconds =
        (worldController.lastElapsedDuration - lastUpdateCall).inMilliseconds /
            1000;

    runDistance += runVelocity * elapsedTimeSeconds;
    setState(() {
      x=(runDistance*2).round() ;
    });

    Size screenSize = MediaQuery.of(context).size;

    Rect dinoRect = dino.getRect(screenSize, runDistance);
    for (Cactus cactus in cacti) {
      Rect obstacleRect = cactus.getRect(screenSize, runDistance);
      if (dinoRect.overlaps(obstacleRect)) {
        _die();
      }

      if (obstacleRect.right < 0) {
        setState(() {
          cacti.remove(cactus);
          cacti.add(Cactus(
              worldLocation:
                  Offset(runDistance + Random().nextInt(100) + 50, 0)));
        });
      }
    }

    for (Ground groundlet in ground) {
      if (groundlet.getRect(screenSize, runDistance).right < 0) {
        setState(() {
          ground.remove(groundlet);
          ground.add(Ground(
              worldLocation: Offset(
                  ground.last.worldLocation.dx + groundSprite.imageWidth / 10,
                  0)));
        });
      }
    }

    for (Cloud cloud in clouds) {
      if (cloud.getRect(screenSize, runDistance).right < 0) {
        setState(() {
          clouds.remove(cloud);
          clouds.add(Cloud(
              worldLocation: Offset(
                  clouds.last.worldLocation.dx + Random().nextInt(100) + 50,
                  Random().nextInt(40) - 20.0)));
        });
      }
    }

    lastUpdateCall = worldController.lastElapsedDuration;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Widget> children = [];

    for (GameObject object in [...clouds, ...ground, ...cacti, dino]) {
      children.add(AnimatedBuilder(
          animation: worldController,
          builder: (context, _) {
            Rect objectRect = object.getRect(screenSize, runDistance);
            return Positioned(
              left: objectRect.left,
              top: objectRect.top,
              width: objectRect.width,
              height: objectRect.height,
              child: object.render(),
            );
          }));
    }

    return SafeArea(
      child: Container(
        child: Scaffold(
          body: ListView(
            children: [
              Container(
                height: 70.h,
                color: Color(0xFF95FAFA),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    dino.jump();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: children,
                  ),
                ),
              ),
              SizedBox(height: 5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        x=0;
                         dino = Dino();
                         runDistance = 0;
                         runVelocity = 30;


                         lastUpdateCall = Duration();
                         cacti = [Cactus(worldLocation: Offset(200, 0))];

                         ground = [
                          Ground(worldLocation: Offset(0, 0)),
                          Ground(worldLocation: Offset(groundSprite.imageWidth / 10, 0))
                        ];

                         clouds = [
                          Cloud(worldLocation: Offset(100, 20)),
                          Cloud(worldLocation: Offset(200, 10)),
                          Cloud(worldLocation: Offset(350, -10)),
                        ];


                      });
                      // worldController.dispose();
                      // worldController = AnimationController(vsync: this, duration: Duration(days: 99));
                      // worldController.addListener(_update);
                      worldController.forward();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),

                      decoration: BoxDecoration(
                          color: fromCssColor('#E2F5FF')
                              .withOpacity(0.4),
                        borderRadius: BorderRadius.circular(15.sp),
                        border: Border.all(width: 0.5.sp,color: Colors.black)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.replay),
                          Text("Replay",
                            style: TextStyle(
                              fontSize: 15.sp,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 1.h),

                      decoration: BoxDecoration(
                          color: fromCssColor('#E2F5FF')
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15.sp),
                          border: Border.all(width: 0.5.sp,color: Colors.black)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.arrow_back_rounded),
                          Text("Back",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h,),
              Center(
                child: Text("Score: $x",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
