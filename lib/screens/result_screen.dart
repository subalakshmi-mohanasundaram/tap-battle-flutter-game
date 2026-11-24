import 'package:flutter/material.dart';

import 'package:finger_tap/models/game_state.dart';
import 'package:finger_tap/utils/app_colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.winner,
    required this.playerAScore,
    required this.playerBScore,
    required this.onPlayAgain,
  });

  final Player winner;
  final int playerAScore;
  final int playerBScore;
  final VoidCallback onPlayAgain;

  @override
  Widget build(BuildContext context) {
    final bool blueWon = winner == Player.a;
    final Color background = blueWon ? AppColors.blue : AppColors.red;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.emoji_events, size: 96, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    'WINNER!',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    GameState.playerName(winner),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: _ScoreCard(
                          name: GameState.playerName(Player.a),
                          score: playerAScore,
                          color: AppColors.blue,
                          isWinner: winner == Player.a,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ScoreCard(
                          name: GameState.playerName(Player.b),
                          score: playerBScore,
                          color: AppColors.red,
                          isWinner: winner == Player.b,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: onPlayAgain,
                    icon: const Icon(Icons.replay),
                    label: const Text('PLAY AGAIN'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: background,
                      minimumSize: const Size.fromHeight(56),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Go back to the first route in the stack (HomeScreen).
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('HOME'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      minimumSize: const Size.fromHeight(56),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A white card showing one player's name and final score.
class _ScoreCard extends StatelessWidget {
  const _ScoreCard({
    required this.name,
    required this.score,
    required this.color,
    required this.isWinner,
  });

  final String name;
  final int score;
  final Color color;
  final bool isWinner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isWinner ? Colors.amber : Colors.transparent,
          width: 4,
        ),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 44,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const Text(
            'taps',
            style: TextStyle(fontSize: 14, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
