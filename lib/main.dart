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

  /// When tapped, if the cell is empty and it is player1's turn, put an X, if it
  /// is player2's turn put an O. If the cell is not empty, do nothing.
  void _onTap() {
    //
  }

  // X's and O's
  List<String> values = List.filled(9, '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Center(
              child: Text(
                values[index],
                style: TextStyle(fontSize: 50),
              ),
            ),
          );
        },
      ),
    );
  }
}
