import 'package:flutter/material.dart';

import 'package:finger_tap/constants/app_constants.dart';
import 'package:finger_tap/screens/game_screen.dart';
import 'package:finger_tap/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _startGame(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int winPercent = AppConstants.winThreshold.round();

    return Scaffold(
      body: Stack(
        children: [
          // Background: blue top half, red bottom half.
          Column(
            children: const [
              Expanded(child: ColoredBox(color: AppColors.blue)),
              Expanded(child: ColoredBox(color: AppColors.red)),
            ],
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Scrollable so small screens never overflow.
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Card(
                            elevation: 8,
                            color: Colors.white,
                            surfaceTintColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.touch_app,
                                    size: 56,
                                    color: AppColors.textDark,
                                  ),
                                  const SizedBox(height: 8),
                                  const Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'TAP ',
                                          style: TextStyle(
                                              color: AppColors.blue),
                                        ),
                                        TextSpan(
                                          text: 'BATTLE',
                                          style:
                                              TextStyle(color: AppColors.red),
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    AppConstants.subtitle,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  const _InstructionRow(
                                    icon: Icons.touch_app,
                                    text:
                                        'Player A taps the blue top area. Player B taps the red bottom area.',
                                  ),
                                  const _InstructionRow(
                                    icon: Icons.swap_vert,
                                    text:
                                        'Every tap grows your colour and shrinks your rival\'s.',
                                  ),
                                  _InstructionRow(
                                    icon: Icons.emoji_events,
                                    text:
                                        'First to own $winPercent% of the screen wins!',
                                  ),
                                  const SizedBox(height: 24),
                                  FilledButton.icon(
                                    onPressed: () => _startGame(context),
                                    icon: const Icon(Icons.play_arrow),
                                    label: const Text('START GAME'),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: AppColors.textDark,
                                      foregroundColor: Colors.white,
                                      minimumSize:
                                          const Size.fromHeight(56),
                                      shape: const StadiumBorder(),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// One line of the instructions: an icon plus text.
/// Private (starts with _) because only this file uses it.
class _InstructionRow extends StatelessWidget {
  const _InstructionRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: AppColors.textMuted),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}