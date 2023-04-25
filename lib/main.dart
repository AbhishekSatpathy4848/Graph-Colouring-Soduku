import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/functions/fetch_puzzle.dart';
import 'package:sudoku_graph_colouring/functions/solve_sudoku.dart';
import 'package:sudoku_graph_colouring/widgets/sudoku_grid_widget.dart';

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
  late List<List<SudokuNodeClass>> sudokuNodesClasses;
  late List<List<SudokuNodeClass>> sudokuNodesClassesQuestion;
  ValueNotifier<bool> showColor = ValueNotifier(false);
  ValueNotifier<bool> solved = ValueNotifier(false);
  SudokuSizes dropDownValue = SudokuSizes.fourByFour;

  // initSudokuNodeClasses(List<List<Color>> sudokuPuzzle) {
  //   for (int i = 0; i < sudokuPuzzle.length; i++) {
  //     List<SudokuNodeClass> row = [];
  //     for (int j = 0; j < sudokuPuzzle[i].length; j++) {
  //       row.add(SudokuNodeClass(
  //           color: sudokuPuzzle[i][j],
  //           boxNumber: (i ~/ sqrt(sudokuNodesClasses.length)) *
  //                   (sqrt(sudokuNodesClasses.length)).toInt() +
  //               (j ~/ sqrt(sudokuNodesClasses.length)),
  //           columnNumber: j,
  //           rowNumber: i));
  //     }
  //     sudokuNodesClasses.add(row);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    sudokuNodesClasses = fetchSudokuPuzzle(dropDownValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Soduku Solver"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  width: MediaQuery.of(context).size.height / 1.4,
                  child: ValueListenableBuilder(
                      valueListenable: solved,
                      builder: (context, value, child) {
                        return SudokuGridWidget(
                            sudokuNodesClasses: sudokuNodesClasses,
                            sudokuSizes: dropDownValue,
                            colorChangeNotifier: showColor);
                      }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DropdownButton<String>(
                          // style: const TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.white,
                          dropdownColor: Colors.amber[300],
                          borderRadius: BorderRadius.circular(10),
                          underline: const Text(""),
                          isDense: true,
                          value: sudokuSizesMap[dropDownValue],
                          selectedItemBuilder: (context) {
                            return SudokuSizes.values
                                .map((e) => DropdownMenuItem<String>(
                                    value: sudokuSizesMap[e],
                                    child: Text(
                                      sudokuSizesMap[e]!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )))
                                .toList();
                          },
                          items: SudokuSizes.values
                              .map((e) => DropdownMenuItem<String>(
                                  value: sudokuSizesMap[e],
                                  child: Text(
                                    sudokuSizesMap[e]!,
                                    style: const TextStyle(color: Colors.black),
                                  )))
                              .toList(),
                          onChanged: (value) async {
                            dropDownValue = inverseSudokuSizesMap[value]!;
                            solved.value = false;
                            setState(() {
                              sudokuNodesClasses =
                                  fetchSudokuPuzzle(dropDownValue);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(16))),
                      onPressed: () {
                        showColor.value = !showColor.value;
                      },
                      child: ValueListenableBuilder(
                          valueListenable: showColor,
                          builder: (context, value, child) {
                            return Text(
                                value as bool ? "Hide Colors" : "Show Colors",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600));
                          }),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(16))),
                      onPressed: () {
                        if (!solved.value) {
                          // sudokuNodesClassesQuestion =
                          // List.from(sudokuNodesClasses);
                          sudokuNodesClassesQuestion = sudokuNodesClasses
                              .map((e) => e
                                  .map((e) =>
                                      SudokuNodeClass.clone(sudokuNodeClass: e))
                                  .toList())
                              .toList();
                          compute(solveSudoku, sudokuNodesClasses)
                              .then((value) {});
                          solved.value = true;
                        } else {
                          sudokuNodesClasses = sudokuNodesClassesQuestion
                              .map((e) => e
                                  .map((e) =>
                                      SudokuNodeClass.clone(sudokuNodeClass: e))
                                  .toList())
                              .toList();
                          solved.value = false;
                        }
                      },
                      child: ValueListenableBuilder(
                          valueListenable: solved,
                          builder: (context, value, child) {
                            return Text(
                              value as bool ? "Show Question" : "Solve",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            );
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

int getBoxNumber(int i, int j, int sudokuLength) {
  return (i ~/ sqrt(sudokuLength)) * (sqrt(sudokuLength)).toInt() +
      (j ~/ sqrt(sudokuLength));
}

List<List<SudokuNodeClass>> convertColorToSudoku(final sudokuPuzzle) {
  List<List<SudokuNodeClass>> res = [];
  for (int i = 0; i < sudokuPuzzle.length; i++) {
    List<SudokuNodeClass> row = [];
    for (int j = 0; j < sudokuPuzzle[i].length; j++) {
      row.add(SudokuNodeClass(
          color: sudokuPuzzle[i][j],
          boxNumber: getBoxNumber(i, j, sudokuPuzzle.length),
          rowNumber: i,
          columnNumber: j));
    }
    res.add(row);
  }
  return res;
}
