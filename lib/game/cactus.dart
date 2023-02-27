import 'dart:math';
import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'constants.dart';
import 'game-object.dart';
import 'sprite.dart';

List<Sprite> CACTI = [
  Sprite()
    ..imagePath = "assets/cacti_group.png"
    ..imageWidth = 34
    ..imageHeight = 60,
  Sprite()
    ..imagePath = "assets/cacti_large_1.png"
    ..imageWidth = 20
    ..imageHeight = 60,
  Sprite()
    ..imagePath = "assets/cacti_large_2.png"
    ..imageWidth = 38
    ..imageHeight = 60,
  Sprite()
    ..imagePath = "assets/cacti_small_1.png"
    ..imageWidth = 14
    ..imageHeight = 50,
  Sprite()
    ..imagePath = "assets/cacti_small_2.png"
    ..imageWidth = 38
    ..imageHeight = 50,
  Sprite()
    ..imagePath = "assets/cacti_small_3.png"
    ..imageWidth = 37
    ..imageHeight = 50,
];

class Cactus extends GameObject {
  final Sprite sprite;
  final Offset worldLocation;

  Cactus({this.worldLocation}) : sprite = CACTI[Random().nextInt(CACTI.length)];

  @override
  Rect getRect(Size screenSize, double runDistance) {
    return Rect.fromLTWH(
      (worldLocation.dx - runDistance) * WORLD_TO_PIXEL_RATIO,
      screenSize.height / 2 - sprite.imageHeight,
      sprite.imageWidth.toDouble(),
      sprite.imageHeight.toDouble(),
    );
  }

  @override
  Widget render() {
    return Image.asset(sprite.imagePath);
  }
}
