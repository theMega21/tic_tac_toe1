import 'dart:io';

void ticTacToe() {
  // Generate ['1', '2', ..., '9']
  List<String> board = List.generate(9, (i) => (i + 1).toString());
  String player = 'X';

  print('Welcome to Tic-Tac-Toe!');

  for (int turn = 0; turn < 9; turn++) {
    printBoard(board);

    stdout.write('Player $player (1-9): ');
    String? move = stdin.readLineSync();

    // Replicates `while move not in board`
    while (move == null || !board.contains(move)) {
      stdout.write('Invalid move. Try again: ');
      move = stdin.readLineSync();
    }

    int index = int.parse(move) - 1;
    board[index] = player;

    if (checkWinner(board, player)) {
      printBoard(board);
      print('Player $player wins!');
      return;
    }

    player = player == 'X' ? 'O' : 'X';
  }

  printBoard(board);
  print("It's a tie!");
}

void main() {
  ticTacToe();
}

void printBoard(List<String> board) {
  for (var row = 0; row < 3; row++) {
    final start = row * 3;
    print(' ${board[start]} | ${board[start + 1]} | ${board[start + 2]}');
    if (row < 2) print('---+---+---');
  }
}

bool checkWinner(List<String> board, String player) {
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
  return winningLines.any(
    (line) => line.every((index) => board[index] == player),
  );
}