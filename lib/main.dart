import 'package:flutter/material.dart';
import 'tic_tac_toe_game.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFEAF1E9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF28634D),
          surface: const Color(0xFFEAF1E9),
        ),
        fontFamily: 'Arial',
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TicTacToeGame _game = TicTacToeGame();
  int _xScore = 0;
  int _oScore = 0;
  int _draws = 0;

  static const _winningLines = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  List<int> get _winningCells {
    for (final line in _winningLines) {
      if (line.every((index) => _game.board[index] == _game.currentPlayer) &&
          _game.gameOver &&
          !_game.gameStatus.contains('Tie')) {
        return line;
      }
    }
    return const [];
  }

  void _play(int index) {
    if (!_game.makeMove(index)) return;
    setState(() {
      if (_game.gameOver) {
        if (_game.gameStatus == 'Player X Wins!') {
          _xScore++;
        } else if (_game.gameStatus == 'Player O Wins!') {
          _oScore++;
        } else {
          _draws++;
        }
      }
    });
  }

  void _restart() {
    setState(_game.resetGame);
  }

  @override
  Widget build(BuildContext context) {
    final highlightedCells = _winningCells;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Tic Tac Toe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF183D31),
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _game.gameStatus,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF476257),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Row(
                    children: [
                      _Score(label: 'X', score: _xScore, color: const Color(0xFF28634D)),
                      _Score(label: 'DRAWS', score: _draws, color: const Color(0xFF64746C)),
                      _Score(label: 'O', score: _oScore, color: const Color(0xFFCC5D4C)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 9,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final mark = _game.board[index];
                            final isMarked = mark == 'X' || mark == 'O';
                            final isWinningCell = highlightedCells.contains(index);
                            final markColor = mark == 'X'
                                ? const Color(0xFF28634D)
                                : const Color(0xFFCC5D4C);

                            return Material(
                              color: isWinningCell
                                  ? const Color(0xFFD1E6D6)
                                  : const Color(0xFFFFFEFA),
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () => _play(index),
                                child: Center(
                                  child: AnimatedScale(
                                    scale: isMarked ? 1 : 0.82,
                                    duration: const Duration(milliseconds: 140),
                                    child: Text(
                                      isMarked ? mark : '',
                                      style: TextStyle(
                                        color: markColor,
                                        fontSize: 64,
                                        fontWeight: FontWeight.w800,
                                        height: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Align(
                    alignment: Alignment.center,
                    child: FilledButton.icon(
                      onPressed: _restart,
                      icon: const Icon(Icons.refresh),
                      label: const Text('New game'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF28634D),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({required this.label, required this.score, required this.color});

  final String label;
  final int score;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$score',
            style: const TextStyle(
              color: Color(0xFF183D31),
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}