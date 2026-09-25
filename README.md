# Tic Tac Toe

A small Flutter tic-tac-toe game for the web. Play locally as X and O, track round scores, and start a fresh board without losing the scores.

## Requirements

- Flutter SDK with Dart 3.4 or newer
- A browser supported by Flutter, such as Chrome

## Run

```powershell
flutter pub get
flutter run -d chrome
```

## Test and analyze

```powershell
flutter analyze
flutter test tests
```

The game rules are in `lib/tic_tac_toe_game.dart`; the Flutter screen is in `lib/main.dart`. The earlier terminal version remains available with `dart src/tic_tac_toe_game.dart`.