import 'package:advent_2023/utils.dart';

void main(List<String> arguments) async {
  final lines = await readInput();

  int result = 0;
  await for (var line in lines) {
    final lineNumericOnly = line.replaceAll(RegExp(r'[^\d]'), '');
    final sum = int.parse(lineNumericOnly[0] + lineNumericOnly[lineNumericOnly.length-1]);
    result += sum;
  }
  print(result);
}