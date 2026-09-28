import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/tic_tac_toe_game.dart';

void main() {
  group('Iteration 3 - Game State and Restart', () {
    late TicTacToeGame game;

    setUp(() {
      game = TicTacToeGame();
    });

    test('Display current player - updates status each turn', () {
      expect(game.gameStatus, "Player X's Turn");

      game.makeMove(0);

      expect(game.gameStatus, "Player O's Turn");
    });

    test('Restart game - resets all state values', () {
      game.makeMove(0);
      game.makeMove(1);

      game.resetGame();

      expect(game.board, ['1', '2', '3', '4', '5', '6', '7', '8', '9']);
      expect(game.currentPlayer, 'X');
      expect(game.gameOver, false);
      expect(game.gameStatus, "Player X's Turn");
    });
  });
}