import 'package:flutter/material.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/functions/utility_functions.dart';
import 'package:sudoku_graph_colouring/main.dart';

List<List<SudokuNodeClass>> fetchSudokuPuzzle(SudokuSizes sudokuSize) {
  List<List<int>> sudoku = [];
  if (sudokuSize == SudokuSizes.fourByFour) {
    sudoku.addAll([
      [3, 0, 4, 0],
      [0, 1, 0, 2],
      [0, 4, 0, 3],
      [2, 0, 1, 0]
    ]);
  } else if (sudokuSize == SudokuSizes.nineByNine) {
    sudoku.addAll([
      [7, 0, 3, 0, 6, 0, 0, 8, 0],
      [0, 0, 0, 0, 7, 2, 0, 0, 0],
      [1, 0, 0, 0, 0, 4, 0, 0, 0],
      [6, 0, 0, 0, 9, 0, 3, 0, 0],
      [0, 0, 8, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 6],
      [0, 0, 0, 0, 0, 0, 0, 7, 0],
      [8, 0, 0, 0, 0, 0, 0, 2, 0],
      [9, 0, 0, 4, 0, 5, 0, 0, 8]
    ]);
  } else if (sudokuSize == SudokuSizes.sixteenBySixteen) {
    sudoku.addAll([
      [15, 12, 8, 0, 1, 0, 4, 3, 5, 0, 7, 10, 9, 13, 11, 14],
      [5, 0, 3, 0, 0, 0, 0, 10, 11, 1, 0, 14, 0, 0, 16, 0],
      [0, 0, 6, 13, 0, 0, 12, 0, 9, 4, 0, 0, 2, 1, 0, 0],
      [0, 0, 0, 1, 11, 13, 0, 0, 0, 3, 8, 0, 0, 5, 7, 10],
      [1, 2, 0, 0, 12, 14, 8, 13, 0, 9, 4, 0, 0, 0, 10, 0],
      [0, 8, 7, 9, 0, 0, 0, 1, 12, 16, 0, 11, 14, 2, 5, 13],
      [0, 0, 16, 11, 5, 6, 2, 0, 13, 0, 0, 15, 8, 0, 12, 0],
      [0, 0, 14, 15, 0, 10, 16, 11, 3, 0, 5, 0, 7, 0, 1, 6],
      [0, 1, 10, 0, 0, 0, 14, 8, 4, 0, 12, 0, 0, 15, 0, 0],
      [3, 4, 9, 6, 16, 0, 0, 0, 10, 0, 0, 0, 12, 14, 13, 5],
      [0, 16, 0, 12, 4, 15, 0, 6, 1, 7, 14, 3, 11, 10, 9, 2],
      [0, 0, 0, 14, 10, 9, 0, 0, 6, 2, 0, 5, 0, 8, 4, 1],
      [0, 3, 0, 4, 2, 0, 0, 0, 8, 12, 6, 13, 0, 0, 0, 16],
      [0, 6, 0, 0, 0, 0, 0, 0, 15, 10, 9, 0, 13, 3, 0, 4],
      [0, 14, 0, 7, 8, 12, 11, 4, 16, 5, 3, 1, 10, 6, 15, 0],
      [16, 5, 15, 10, 0, 3, 6, 9, 0, 11, 2, 4, 0, 7, 8, 12],
    ]);
  }

  return convertColorToSudoku(sudoku
      .map((e) => e.map((e) => numberToColorMap[e] ?? Colors.white).toList())
      .toList());
  // return convertForm(sudoku);
}

List<List<String>> convertForm(List<List<int>> sudoku) {
  return sudoku
      .map((e) => e.map((e) => convertToAlphabetsAndNumbers(e)).toList())
      .toList();
}
