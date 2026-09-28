import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/tic_tac_toe_game.dart';

void main() {
  group('Iteration 1 - Basic Game', () {
    late TicTacToeGame game;

    setUp(() {
      game = TicTacToeGame();
    });

    test('1. Start a new game - board initialized correctly', () {
      expect(game.board, ['1', '2', '3', '4', '5', '6', '7', '8', '9']);
      expect(game.currentPlayer, 'X');
      expect(game.gameOver, false);
      expect(game.gameStatus, "Player X's Turn");
    });

    test('2. Place a mark - updates board state', () {
      game.makeMove(0);

      expect(game.board[0], 'X');
    });

    test('3. Alternate players - switches from X to O and back', () {
      expect(game.currentPlayer, 'X');

      game.makeMove(0);

      expect(game.currentPlayer, 'O');

      game.makeMove(1);

      expect(game.currentPlayer, 'X');
    });

    test('4. Prevent occupied-space moves - ignores occupied tile', () {
      game.makeMove(0);

      final bool moveSuccessful = game.makeMove(0);

      expect(moveSuccessful, false);
      expect(game.board[0], 'X');
      expect(game.currentPlayer, 'O');
    });

    test('5. Detect horizontal wins - top row win for X', () {
      game.makeMove(0);
      game.makeMove(3);
      game.makeMove(1);
      game.makeMove(4);
      game.makeMove(2);

      expect(game.checkWinner('X'), true);
      expect(game.gameOver, true);
      expect(game.gameStatus, 'Player X Wins!');
    });
  });
}