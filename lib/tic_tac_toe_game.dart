class TicTacToeGame {
  List<String> board = List.generate(9, (index) => '${index + 1}');
  String currentPlayer = 'X';
  bool gameOver = false;
  String? _winner;
  bool _tie = false;

  String get gameStatus {
    if (_winner != null) return 'Player $_winner Wins!';
    if (_tie) return "It's a Tie!";
    return "Player $currentPlayer's Turn";
  }

  bool makeMove(int index) {
    if (gameOver || index < 0 || index >= board.length) return false;
    if (board[index] == 'X' || board[index] == 'O') return false;

    board[index] = currentPlayer;
    if (checkWinner(currentPlayer)) return true;
    if (checkTie()) return true;

    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
    return true;
  }

  bool checkWinner(String player) {
    const winningLines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    final hasWon = winningLines.any(
      (line) => line.every((index) => board[index] == player),
    );
    if (hasWon) {
      gameOver = true;
      _winner = player;
    }
    return hasWon;
  }

  bool checkTie() {
    if (gameOver) return _tie;
    if (board.any((cell) => cell != 'X' && cell != 'O')) return false;
    gameOver = true;
    _tie = true;
    return true;
  }

  void resetGame() {
    board = List.generate(9, (index) => '${index + 1}');
    currentPlayer = 'X';
    gameOver = false;
    _winner = null;
    _tie = false;
  }
}