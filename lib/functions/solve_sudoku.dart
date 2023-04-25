import 'dart:math';

import 'package:sudoku_graph_colouring/functions/generate_adjacency_list.dart';
import 'package:sudoku_graph_colouring/constants/number_color_map.dart';
import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';
import 'package:sudoku_graph_colouring/functions/utility_functions.dart';

bool solveSudoku(List<List<SudokuNodeClass>> sudokuNodesClasses) {
  final adjList = generateAdjacencyList(sudokuNodesClasses);
  return colorise(adjList, convertTo1D(sudokuNodesClasses));
}

bool colorise(Map<SudokuNodeClass, List<SudokuNodeClass>> adjacencyList,
    List<SudokuNodeClass> nodes) {
  for (var node in nodes) {
    if (node.color == notColoured) {
      for (int colorNumber = 1;
          colorNumber <= sqrt(nodes.length);
          colorNumber++) {
        if (checkValidColor(
            adjacencyList, node, numberToColorMap[colorNumber]!)) {
          node.color = numberToColorMap[colorNumber]!;
          if (colorise(adjacencyList, nodes)) return true;
          node.color = notColoured;
        }
      }
      return false;
    }
  }
  return true;
}

bool checkValidColor(final adjacencyList, final node, final color) {
  for (var neighbour in adjacencyList[node]!) {
    if (neighbour.color == color) {
      return false;
    }
  }
  return true;
}
