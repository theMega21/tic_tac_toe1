import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/main.dart';

void main() {
  testWidgets('shows the board and updates turn after a move', (tester) async {
    await tester.pumpWidget(const TicTacToeApp());
    final boardCells = find.descendant(
      of: find.byType(GridView),
      matching: find.byType(InkWell),
    );

    expect(find.text('Tic Tac Toe'), findsOneWidget);
    expect(boardCells, findsNWidgets(9));
    expect(find.text("Player X's Turn"), findsOneWidget);

    await tester.tap(boardCells.first);
    await tester.pumpAndSettle();

    expect(find.text("Player O's Turn"), findsOneWidget);
  });
}