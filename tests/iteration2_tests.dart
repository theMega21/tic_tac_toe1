import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/tic_tac_toe_game.dart';

void main() {
  group('Iteration 2 - Game Rules', () {
    late TicTacToeGame game;

    setUp(() {
      game = TicTacToeGame();
    });

    test('Vertical win - left column win for O', () {
      game.makeMove(1);
      game.makeMove(0);
      game.makeMove(2);
      game.makeMove(3);
      game.makeMove(4);
      game.makeMove(6);

      expect(game.checkWinner('O'), true);
      expect(game.gameOver, true);
      expect(game.gameStatus, 'Player O Wins!');
    });

    test('Diagonal win - main diagonal win for X', () {
      game.makeMove(0);
      game.makeMove(1);
      game.makeMove(4);
      game.makeMove(2);
      game.makeMove(8);

      expect(game.checkWinner('X'), true);
      expect(game.gameOver, true);
    });

    test('Game ends after a win - prevents further moves', () {
      game.makeMove(0);
      game.makeMove(3);
      game.makeMove(1);
      game.makeMove(4);
      game.makeMove(2);

      expect(game.gameOver, true);

      final bool extraMove = game.makeMove(5);

      expect(extraMove, false);
      expect(game.board[5], '6');
    });

    test('Detect draw - full board with no winner', () {
      final moves = [0, 1, 2, 4, 3, 5, 7, 6, 8];

      for (final move in moves) {
        game.makeMove(move);
      }

      expect(game.checkTie(), true);
      expect(game.gameOver, true);
      expect(game.gameStatus, "It's a Tie!");
    });
  });
}