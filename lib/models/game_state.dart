import 'package:finger_tap/constants/app_constants.dart';

/// The three stages of one round.
enum GameStatus { countdown, playing, finished }

/// The two players. Player A = blue (top), Player B = red (bottom).
enum Player { a, b }

class GameState {
  int playerAScore = 0;
  int playerBScore = 0;

  /// Only blue is stored. Red is calculated from it, so
  /// blue + red is ALWAYS exactly 100.
  double blueTerritory = AppConstants.initialTerritory;

  GameStatus status = GameStatus.countdown;

  /// null until somebody wins.
  Player? winner;

  double get redTerritory => 100 - blueTerritory;
  bool get isPlaying => status == GameStatus.playing;
  bool get isFinished => status == GameStatus.finished;

  /// Display name for a player.
  static String playerName(Player player) {
    return player == Player.a
        ? AppConstants.playerAName
        : AppConstants.playerBName;
  }

  /// Called when the countdown ends. Taps are accepted from now on.
  void startGame() {
    if (status == GameStatus.countdown) {
      status = GameStatus.playing;
    }
  }

  /// Player A (blue) taps. Returns true if the tap counted.
  bool tapBlue() {
    if (!isPlaying) return false; // countdown or already finished
    playerAScore++;
    blueTerritory = (blueTerritory + AppConstants.territoryStep)
        .clamp(0.0, 100.0)
        .toDouble();
    determineWinner();
    return true;
  }

  /// Player B (red) taps. Returns true if the tap counted.
  bool tapRed() {
    if (!isPlaying) return false;
    playerBScore++;
    blueTerritory = (blueTerritory - AppConstants.territoryStep)
        .clamp(0.0, 100.0)
        .toDouble();
    determineWinner();
    return true;
  }

  /// Checks the winning condition. Only works while playing,
  /// so a winner can be declared only once.
  void determineWinner() {
    if (!isPlaying) return;

    if (blueTerritory >= AppConstants.winThreshold) {
      winner = Player.a;
      status = GameStatus.finished;
    } else if (redTerritory >= AppConstants.winThreshold) {
      winner = Player.b;
      status = GameStatus.finished;
    }
  }

  /// Puts everything back to the starting values.
  void resetGame() {
    playerAScore = 0;
    playerBScore = 0;
    blueTerritory = AppConstants.initialTerritory;
    status = GameStatus.countdown;
    winner = null;
  }
}
