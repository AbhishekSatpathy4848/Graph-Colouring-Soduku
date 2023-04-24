import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: SodukuSolver(),
  ));
}

class SodukuSolver extends StatefulWidget {
  const SodukuSolver({Key? key}) : super(key: key);

  @override
  State<SodukuSolver> createState() => _SodukuSolverState();
}

class _SodukuSolverState extends State<SodukuSolver> {
  @override
  void initState() {
    super.initState();
    // fetchSodukuPuzzle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soduku Solver"),
      ),
      body: MaterialButton(
        onPressed: () {},
        color: Colors.blue,
      ),
    );
  }
}
