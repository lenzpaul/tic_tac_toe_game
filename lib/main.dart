import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

/// A tic-tac-toe game.
///
/// This is the main app widget.
class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

/// The main screen of the app.
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Truxe if it is player1's turn, false if it is player2's turn.
  bool player1turn = true;

  /// X's and O's are stored in this list.
  List<String> values = List.filled(9, '');

  /// When tapped, if the cell is empty and it is player1's turn, put an X, if it
  /// is player2's turn put an O. If the cell is not empty, do nothing.
  void _onTap(int index) async {
    if (values[index].isNotEmpty) return; // do nothing

    // Paint X or O
    values[index] = player1turn ? 'X' : 'O';
    setState(() {});

    // Check if the game is over
    if (didWin(values)) {
      print("Game over ${player1turn ? 'player1' : 'player2'} won");

      // Show game over dialog, with the option to restart the game
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text("Game over ${player1turn ? 'player1' : 'player2'} won!"),
            actions: [
              // Play again button
              TextButton(
                onPressed: () {
                  // Reset the values
                  values = List.filled(9, '');

                  // Remove the dialog
                  Navigator.pop(context);

                  player1turn = true;

                  // Refresh screen with no X's or O's
                  setState(() {});
                },
                child: const Text('Play again'),
              ),
            ],
          );
        },
      );
    } else if (isDraw(values)) {
      print("Game over, it's a draw");

      // Show game over dialog, with the option to restart the game
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Game over, it's a draw!"),
            actions: [
              // Play again button
              TextButton(
                onPressed: () {
                  // Reset the values
                  values = List.filled(9, '');

                  // Remove the dialog
                  Navigator.pop(context);

                  player1turn = true;

                  // Refresh screen with no X's or O's
                  setState(() {});
                },
                child: const Text('Play again'),
              ),
            ],
          );
        },
      );
    }

    //
    else {
      // Game not over, change player turn
      player1turn = !player1turn;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe Game!'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        // A grid view with 9 cells (3x3)
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _onTap(index),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    values[index],
                    style: const TextStyle(fontSize: 50),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Returns true if there are no empty cells left and there is no winner.
bool isDraw(List<String> values) {
  // If there is a winner, it is not a draw
  if (didWin(values)) return false;

  // If there is an empty cell, it is not a draw
  if (values.any((cell) => cell.isEmpty)) return false;

  // If there is no empty cell and no winner, it is a draw
  return true;
}

/// Returns true if the current board state has a winner.
bool didWin(List<String> values) {
  return _horizontal(values) || _vertical(values) || _diagonal(values);
}

/// Returns true if any horizontal line has all X's or all O's
///
/// horizontal: any combination of these has all Os or all Xs
/// 0,1,2
/// 3,4,5
/// 6,7,8
bool _horizontal(List<String> values) {
  // 0,1,2
  if (values[0].isNotEmpty &&
      values[0] == values[1] &&
      values[1] == values[2]) {
    return true;
  }

  // 3,4,5
  else if (values[3].isNotEmpty &&
      values[3] == values[4] &&
      values[4] == values[5]) {
    return true;
  }
  // 6,7,8
  else if (values[6].isNotEmpty &&
      values[6] == values[7] &&
      values[7] == values[8]) {
    return true;
  } else {
    return false;
  }
}

/// Returns true if any vertical line has all X's or all O's
///
/// vertical winning combinations:
/// 0,3,6
/// 1,4,7
/// 2,5,8
bool _vertical(List<String> values) {
  // 0,3,6
  if (values[0].isNotEmpty &&
      values[0] == values[3] &&
      values[3] == values[6]) {
    return true;
  }
  // 1,4,7
  else if (values[1].isNotEmpty &&
      values[1] == values[4] &&
      values[4] == values[7]) {
    return true;
  }
  // 2,5,8
  else if (values[2].isNotEmpty &&
      values[2] == values[5] &&
      values[5] == values[8]) {
    return true;
  } else {
    return false;
  }
}

/// Returns true if any diagonal line has all X's or all O's
///
/// diagonal winning combinations:
/// 0,4,8
/// 2,4,6
bool _diagonal(List<String> values) {
  // 0,4,8
  if (values[0].isNotEmpty &&
      values[0] == values[4] &&
      values[4] == values[8]) {
    return true;
  }
  // 2,4,6
  else if (values[2].isNotEmpty &&
      values[2] == values[4] &&
      values[4] == values[6]) {
    return true;
  } else {
    return false;
  }
}
