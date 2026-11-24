import 'package:flutter/material.dart';

import 'package:finger_tap/constants/app_constants.dart';
import 'package:finger_tap/widgets/score_display.dart';

class PlayerArea extends StatelessWidget {
  const PlayerArea({
    super.key,
    required this.height,
    required this.color,
    required this.playerName,
    required this.score,
    required this.territoryPercent,
    required this.onTap,
  });

  final double height;
  final Color color;
  final String playerName;
  final int score;
  final int territoryPercent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTapDown fires the moment the finger touches the screen,
      // which feels faster than onTap (fires when the finger lifts).
      onTapDown: (_) => onTap(),
      child: AnimatedContainer(
        duration: AppConstants.animationDuration,
        curve: Curves.easeOut,
        width: double.infinity,
        height: height,
        color: color,
        child: ClipRect(
          child: Center(
            // Shrinks the content if the area becomes very small.
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: ScoreDisplay(
                playerName: playerName,
                score: score,
                territoryPercent: territoryPercent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
