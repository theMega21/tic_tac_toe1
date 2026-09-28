import 'dart:io';

import 'package:tic_tac_toe/tic_tac_toe_game.dart';

void main() {
  final game = TicTacToeGame();
  print('Welcome to Tic-Tac-Toe!');

  while (!game.gameOver) {
    printBoard(game.board);
    stdout.write('Player ${game.currentPlayer} (1-9): ');

    while (true) {
      final input = stdin.readLineSync();
      if (input == null) return;

      final move = int.tryParse(input.trim());
      if (move != null && move >= 1 && move <= 9 && game.makeMove(move - 1)) {
        break;
      }

      stdout.write('Invalid move. Try again: ');
    }
  }

  printBoard(game.board);
  print(game.gameStatus);
}

void printBoard(List<String> board) {
  for (var row = 0; row < 3; row++) {
    final start = row * 3;
    print(' ${board[start]} | ${board[start + 1]} | ${board[start + 2]}');
    if (row < 2) print('---+---+---');
  }
}