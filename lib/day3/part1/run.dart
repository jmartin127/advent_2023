import 'dart:io';

import 'package:advent_2023/utils.dart';
import 'package:validators/validators.dart';

class PartNumber {
  int startX;
  int startY;
  int length;
  int number;

  PartNumber(this.startX, this.startY, this.length, this.number);

  @override
  String toString() {
    return 'PartNumber: startX:$startX, startY:$startY, length:$length, number:$number';
  }
}

class Cell {
  String char;
  bool isSymbol;
  bool isAdjacent;
  int x;
  int y;

  Cell(this.char, this.isSymbol, this.isAdjacent, this.x, this.y);
}

void main(List<String> arguments) async {
  final lines = readInutLines();
  final partNumbers = await readPartNumbers(lines);
  final matrix = readMatrix(lines);
  markAdjacent(matrix);

  // add up part numbers
  int result = 0;
  for (final part in partNumbers) {
    if (isPart(part, matrix)) {
      result += part.number;
    }
  }
  print(result);
}

// any number adjacent to a symbol, even diagonally, is a "part number" and should be included in your sum
bool isPart(PartNumber part, List<List<Cell>> matrix) {
  for (int x = part.startX; x < part.startX + part.length; x++) {
    if (matrix[part.startY][x].isAdjacent) {
      return true;
    } 
  }
  return false;
}

void markAdjacent(List<List<Cell>> matrix) {
  for (final row in matrix) {
    for (final cell in row) {
      if (cell.isSymbol) {
        markAdjacentCells(matrix, cell);
      }
    }
  }
}

void markAdjacentCells(List<List<Cell>> matrix, Cell cell) {
  for (int y = cell.y - 1; y <= cell.y + 1; y++) {
    for (int x = cell.x - 1; x <= cell.x + 1; x++) {
      if (isInBounds(matrix, x, y)) {
        matrix[y][x].isAdjacent = true;
      }
    }
  }
}

bool isInBounds(List<List<Cell>> matrix, int x, int y) {
  if (x < 0 || y < 0) {
    return false;
  }
  if (x >= matrix[0].length) {
    return false;
  }
  if (y >= matrix.length) {
    return false;
  }

  return true;
}

void printMatrix(List<List<Cell>> matrix) {
  for (final row in matrix) {
    for (final cell in row) {
      stdout.write(cell.char);
    }
    print('\n');
  }
}

List<List<Cell>> readMatrix(List<String> lines) {
  List<List<Cell>> matrix = [];
  for (int y = 0; y < lines.length; y++) {
    final line = lines[y];
    final List<Cell> row = [];
    for (int x = 0; x < line.length; x++) {
      final char = line[x];
      bool isSymbol = false;
      if (char != '.' && !isNumeric(char)) {
        isSymbol = true;
      }
      final cell = Cell(char, isSymbol, false, x, y);
      row.add(cell);
    }
    matrix.add(row);
  }
  return matrix;
}

Future<List<PartNumber>> readPartNumbers(List<String> lines) async {
  List<PartNumber> partNumbers = [];
  int y = 0;
  for (final line in lines) {
    bool inNumber = false;
    String currentNumber = '';
    int startX = -1;
    int startY = -1;
    for (int x = 0; x < line.length; x++) {
      final char = line[x];
      if (isNumeric(char)) {
        // append to the number
        currentNumber += char;
        // start of new number
        if (!inNumber) {
          startX = x;
          startY = y;
          inNumber = true;
        }
      } else {
        // end the current number
        if (inNumber) {
          partNumbers.add(PartNumber(startX, startY, currentNumber.length, int.parse(currentNumber)));
        }
        // reset at end of a number
        currentNumber = '';
        inNumber = false;
      }
    }
  
    y++;
    // end the current number
    if (inNumber) {
      partNumbers.add(PartNumber(startX, startY, currentNumber.length, int.parse(currentNumber)));
    }
    // reset at the end of the row
    currentNumber = '';
    inNumber = false;
  }

  return partNumbers;
}