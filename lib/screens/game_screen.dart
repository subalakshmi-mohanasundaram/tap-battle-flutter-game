import 'dart:async';

import 'package:flutter/material.dart';

import 'package:finger_tap/constants/app_constants.dart';
import 'package:finger_tap/models/game_state.dart';
import 'package:finger_tap/screens/result_screen.dart';
import 'package:finger_tap/utils/app_colors.dart';
import 'package:finger_tap/widgets/countdown_overlay.dart';
import 'package:finger_tap/widgets/player_area.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GameState _game = GameState();

  // One timer variable is reused for the countdown, the "GO!" display
  // and the short pause before the result. Only one is active at a time.
  Timer? _timer;

  int _secondsLeft = AppConstants.countdownStart;

  // Text shown on the overlay. null = overlay hidden.
  String? _countdownText = '${AppConstants.countdownStart}';

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    // Stops any pending timer so nothing runs after the screen is gone.
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(AppConstants.countdownTick, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_secondsLeft > 1) {
        setState(() {
          _secondsLeft--;
          _countdownText = '$_secondsLeft';
        });
      } else {
        // Countdown finished: stop ticking, show GO!, accept taps.
        timer.cancel();
        setState(() {
          _game.startGame();
          _countdownText = 'GO!';
        });
        _timer = Timer(AppConstants.goDisplayDuration, () {
          if (!mounted) return;
          setState(() => _countdownText = null);
        });
      }
    });
  }

  void _handleBlueTap() {
    final bool counted = _game.tapBlue();
    if (!counted) return; // ignored (countdown or finished)
    setState(() {}); // rebuild with the new score and territory
    _checkIfFinished();
  }

  void _handleRedTap() {
    final bool counted = _game.tapRed();
    if (!counted) return;
    setState(() {});
    _checkIfFinished();
  }

  void _checkIfFinished() {
    if (_game.isFinished) {
      _timer?.cancel();
      _timer = Timer(AppConstants.resultDelay, _openResult);
    }
  }

  void _openResult() {
    if (!mounted) return;
    final Player? winner = _game.winner;
    if (winner == null) return;

    // Save the navigator BEFORE this screen is replaced. This screen's own
    // context will be dead afterwards, but the navigator stays valid.
    final NavigatorState navigator = Navigator.of(context);

    navigator.pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ResultScreen(
          winner: winner,
          playerAScore: _game.playerAScore,
          playerBScore: _game.playerBScore,
          // Play Again = replace the result with a brand-new GameScreen,
          // which creates a fresh GameState and starts a new countdown.
          onPlayAgain: () => navigator.pushReplacement(
            MaterialPageRoute<void>(builder: (_) => const GameScreen()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double totalHeight = constraints.maxHeight;
          final double blueHeight = totalHeight * _game.blueTerritory / 100;
          final double redHeight = totalHeight - blueHeight;

          return Stack(
            children: [
              Column(
                children: [
                  PlayerArea(
                    height: blueHeight,
                    color: AppColors.blue,
                    playerName: AppConstants.playerAName,
                    score: _game.playerAScore,
                    territoryPercent: _game.blueTerritory.round(),
                    onTap: _handleBlueTap,
                  ),
                  PlayerArea(
                    height: redHeight,
                    color: AppColors.red,
                    playerName: AppConstants.playerBName,
                    score: _game.playerBScore,
                    territoryPercent: _game.redTerritory.round(),
                    onTap: _handleRedTap,
                  ),
                ],
              ),
              if (_countdownText != null)
                Positioned.fill(
                  child: IgnorePointer(
                    // While "GO!" is showing the game is already running,
                    // so let taps pass through the overlay.
                    ignoring: _game.isPlaying,
                    child: CountdownOverlay(text: _countdownText!),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
