# TAP BATTLE – Two-Player Finger Tap Game

A two-player tap battle game built with **Flutter** and **Dart**. Two players share one screen and fight for territory by tapping as fast as they can.

## Overview

Player A owns the **blue** top half and Player B owns the **red** bottom half. Every tap grows your colour by 2% and shrinks your rival's by 2%. The first player to own **90%** of the screen wins. The game is fully offline and needs no backend.

## Features

- Home screen with title, instructions and a single Start Game button
- 3 – 2 – 1 – GO! countdown (taps are blocked until it ends)
- Animated, percentage-based territory (works on any screen size)
- Live score and territory display for both players
- Winner detection with a dedicated result screen
- Play Again (fresh game and countdown) and Home buttons
- Unit tests for the game rules
- Material Design 3 UI

## Technologies Used

- Flutter SDK
- Dart
- Material Design 3
- Visual Studio Code
- Git and GitHub

## Flutter Concepts Demonstrated

- `StatelessWidget` and `StatefulWidget`, `setState()`
- `LayoutBuilder`, `Expanded`, `Column`, `Row`, `Stack`
- `AnimatedContainer` and `AnimatedSwitcher`
- `GestureDetector`
- `Navigator`, `MaterialPageRoute`, `pushReplacement`, `popUntil`
- `Timer` with cleanup in `dispose()`
- Callbacks (`VoidCallback`)
- Reusable widgets and constructors
- Enums, getters and OOP (separate `GameState` model)
- Unit testing with `flutter_test`

## Project Structure

```
finger_tap/
├── lib/
│   ├── main.dart
│   ├── app/app.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── game_screen.dart
│   │   └── result_screen.dart
│   ├── widgets/
│   │   ├── player_area.dart
│   │   ├── score_display.dart
│   │   └── countdown_overlay.dart
│   ├── models/game_state.dart
│   ├── utils/app_colors.dart
│   └── constants/app_constants.dart
├── test/game_state_test.dart
├── screenshots/
├── android/  ios/  web/  windows/  linux/  macos/
├── pubspec.yaml
└── README.md
```

## Requirements

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Visual Studio Code with the Flutter and Dart extensions
- Google Chrome (for web) or an Android emulator / device

## Installation

```powershell
git clone https://github.com/YOUR_USERNAME/tap-battle-flutter-game.git
cd tap-battle-flutter-game
flutter pub get
```

## How to Run

```powershell
flutter run -d chrome        # run in Chrome
flutter devices              # list available devices
flutter run -d <device-id>   # run on an Android emulator or phone
flutter test                 # run unit tests
flutter analyze              # static analysis
```

## How to Play

1. Press **START GAME**.
2. Wait for the 3 – 2 – 1 – GO! countdown.
3. **Player A** taps the **blue** top area. **Player B** taps the **red** bottom area.
4. Each tap gives you +1 score and +2% territory.
5. First to reach **90%** territory wins.

## Screenshots

| Home | Game | Result |
|------|------|--------|
| ![Home](screenshots/home.png) | ![Game](screenshots/game.png) | ![Result](screenshots/result.png) |

## Future Enhancements

- Sound effects and haptic feedback
- Best-of-3 match mode
- Adjustable winning threshold and difficulty
- Persistent win counter using local storage
- Custom player names
- Landscape layout for tablets

## Author

**YOUR_NAME**
GitHub: [@YOUR_USERNAME](https://github.com/YOUR_USERNAME)

## Repository

https://github.com/YOUR_USERNAME/tap-battle-flutter-game