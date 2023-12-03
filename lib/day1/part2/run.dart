import 'package:advent_2023/utils.dart';

final Map<String, int> numbers = {'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8,  'nine': 9};

void main(List<String> arguments) async {
  final lines = await readInput();

  int result = 0;
  await for (String line in lines) {
    // replace first instance of each word number
    int minIndex = 10000000;
    String minWord = '';
    for (final entry in numbers.entries) {
      final pos = line.indexOf(entry.key);
      if (pos != -1 && pos < minIndex) {
        minIndex = pos;
        minWord = entry.key;
      }
    }
    if (minWord.isNotEmpty) {
      line = line.replaceFirst(minWord, '${numbers[minWord]!}');
    }

    // replace last instance of each word number
    int maxIndex = -1;
    String maxWord = '';
    for (final entry in numbers.entries) {
      final pos = line.lastIndexOf(entry.key);
      if (pos != -1 && pos > maxIndex) {
        maxIndex = pos;
        maxWord = entry.key;
      }
    }
    if (maxWord.isNotEmpty) {
      line = line.replaceFirst(maxWord, '${numbers[maxWord]!}');
    }

    final lineNumericOnly = line.replaceAll(RegExp(r'[^\d]'), '');
    final sum = int.parse(lineNumericOnly[0] + lineNumericOnly[lineNumericOnly.length-1]);
    result += sum;
  }
  print(result);
}