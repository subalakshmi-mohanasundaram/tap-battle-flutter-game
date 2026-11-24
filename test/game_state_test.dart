import 'package:flutter_test/flutter_test.dart';

import 'package:finger_tap/models/game_state.dart';

void main() {
  group('GameState', () {
    late GameState game;

    setUp(() {
      game = GameState(); // a fresh game before every test
    });

    test('starts in countdown with 50/50 territory and zero scores', () {
      expect(game.status, GameStatus.countdown);
      expect(game.blueTerritory, 50);
      expect(game.redTerritory, 50);
      expect(game.playerAScore, 0);
      expect(game.playerBScore, 0);
      expect(game.winner, isNull);
    });

    test('taps are ignored during the countdown', () {
      expect(game.tapBlue(), isFalse);
      expect(game.tapRed(), isFalse);
      expect(game.playerAScore, 0);
      expect(game.playerBScore, 0);
      expect(game.blueTerritory, 50);
    });

    test('blue tap only changes Player A score and grows blue', () {
      game.startGame();
      expect(game.tapBlue(), isTrue);
      expect(game.playerAScore, 1);
      expect(game.playerBScore, 0);
      expect(game.blueTerritory, 52);
      expect(game.redTerritory, 48);
    });

    test('red tap only changes Player B score and grows red', () {
      game.startGame();
      expect(game.tapRed(), isTrue);
      expect(game.playerBScore, 1);
      expect(game.playerAScore, 0);
      expect(game.redTerritory, 52);
      expect(game.blueTerritory, 48);
    });

    test('territories always total 100 and stay between 0 and 100', () {
      game.startGame();
      for (int i = 0; i < 15; i++) {
        if (i % 3 == 0) {
          game.tapRed();
        } else {
          game.tapBlue();
        }
        expect(game.blueTerritory + game.redTerritory, 100);
        expect(game.blueTerritory, inInclusiveRange(0, 100));
        expect(game.redTerritory, inInclusiveRange(0, 100));
      }
    });

    test('Player A wins when blue reaches 90%', () {
      game.startGame();
      for (int i = 0; i < 19; i++) {
        game.tapBlue();
      }
      expect(game.status, GameStatus.playing);
      expect(game.winner, isNull);

      game.tapBlue(); // 20th tap -> 90%
      expect(game.status, GameStatus.finished);
      expect(game.winner, Player.a);
      expect(game.blueTerritory, 90);
      expect(game.redTerritory, 10);
      expect(game.playerAScore, 20);
    });

    test('Player B wins when red reaches 90%', () {
      game.startGame();
      for (int i = 0; i < 20; i++) {
        game.tapRed();
      }
      expect(game.status, GameStatus.finished);
      expect(game.winner, Player.b);
      expect(game.playerBScore, 20);
    });

    test('no taps are accepted after the game is finished', () {
      game.startGame();
      for (int i = 0; i < 20; i++) {
        game.tapBlue();
      }
      expect(game.tapBlue(), isFalse);
      expect(game.tapRed(), isFalse);
      expect(game.playerAScore, 20);
      expect(game.playerBScore, 0);
      expect(game.winner, Player.a);
    });

    test('alternating taps keep the game level and nobody wins', () {
      game.startGame();
      for (int i = 0; i < 100; i++) {
        game.tapBlue();
        game.tapRed();
      }
      expect(game.blueTerritory, 50);
      expect(game.status, GameStatus.playing);
      expect(game.winner, isNull);
    });

    test('resetGame restores every value', () {
      game.startGame();
      for (int i = 0; i < 20; i++) {
        game.tapBlue();
      }
      game.resetGame();

      expect(game.status, GameStatus.countdown);
      expect(game.playerAScore, 0);
      expect(game.playerBScore, 0);
      expect(game.blueTerritory, 50);
      expect(game.redTerritory, 50);
      expect(game.winner, isNull);
    });
  });
}
