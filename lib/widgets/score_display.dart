import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({
    super.key,
    required this.playerName,
    required this.score,
    required this.territoryPercent,
  });

  final String playerName;
  final int score;
  final int territoryPercent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          playerName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '$score',
          style: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          '$territoryPercent% territory',
          style: const TextStyle(fontSize: 16, color: Colors.white70),
        ),
      ],
    );
  }
}
