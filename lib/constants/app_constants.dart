class AppConstants {
  AppConstants._();

  // Texts
  static const String appTitle = 'TAP BATTLE';
  static const String subtitle = 'Two Player Finger Tap Challenge';
  static const String playerAName = 'Player A';
  static const String playerBName = 'Player B';

  // Game rules
  static const double initialTerritory = 50; // percent
  static const double territoryStep = 2; // percent gained per tap
  static const double winThreshold = 90; // percent needed to win

  // Timing
  static const int countdownStart = 3;
  static const Duration countdownTick = Duration(seconds: 1);
  static const Duration goDisplayDuration = Duration(milliseconds: 700);
  static const Duration resultDelay = Duration(milliseconds: 500);
  static const Duration animationDuration = Duration(milliseconds: 150);
}
