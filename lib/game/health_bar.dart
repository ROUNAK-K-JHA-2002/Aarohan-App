import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'player.dart';

class HealthBar extends PositionComponent {
  final Player player;

  HealthBar({
     this.player,
    position,
    size,
    scale,
    angle,
    anchor,
    children,
    priority,
  }) {
    positionType = PositionType.viewport;
  }

  @override
  void render(Canvas canvas) {
    // Draws a rectangular health bar at top right corner.
    canvas.drawRect(
      Rect.fromLTWH(-2, 5, player.health.toDouble(), 20),
      Paint()..color = Colors.blue,
    );
    super.render(canvas);
  }
}
