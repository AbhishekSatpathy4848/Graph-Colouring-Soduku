import 'package:sudoku_graph_colouring/classes/sudoku_node_class.dart';

List<SudokuNodeClass> convertTo1D(
    List<List<SudokuNodeClass>> sudokuNodesClasses) {
  return [for (var row in sudokuNodesClasses) ...row];
}

SudokuNodeClass? getNodeWithCoordinates(
    int row, int column, List<List<SudokuNodeClass>> sudokuNodesClasses) {
  for (final i in sudokuNodesClasses) {
    for (final j in i) {
      if (j.rowNumber == row && j.columnNumber == column) {
        return j;
      }
    }
  }
  return null;
}

bool isBorderNode(SudokuNodeClass node, int sudokuSize){
  if(node.rowNumber == 0 || node.rowNumber == sudokuSize-1 || node.columnNumber == 0 || node.columnNumber == sudokuSize-1){
    return true;
  }
  return false;
}

String convertToAlphabetsAndNumbers(int n) {
  if (n >= 10) {
    return String.fromCharCode(n - 10 + 65);
  }
  return n.toString();
}
