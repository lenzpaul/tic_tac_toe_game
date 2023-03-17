import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

/// A tic-tac-toe game.
class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool player1turn = true;

  /// X's and O's
  List<String> values = List.filled(9, '');

  /// When tapped, if the cell is empty and it is player1's turn, put an X, if it
  /// is player2's turn put an O. If the cell is not empty, do nothing.
  void _onTap(int index) {
    //
    print("tapped $index");

    if (values[index].isEmpty) {
      values[index] = player1turn ? 'X' : 'O';
      player1turn = !player1turn;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
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
    );
  }
}
