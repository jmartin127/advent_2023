import 'package:advent_2023/utils.dart';

void main(List<String> arguments) async {
  final lines = await readInput();

  int result = 0;
  await for (var line in lines) {
    Map<String, int> maxColorCounts = {'red': 1, 'green': 1, 'blue': 1};
    final gamePrefix = line.split(': ');
    for (final sub in gamePrefix[1].split('; ')) {
      incrementMax(sub, maxColorCounts);
    }
    final power = maxColorCounts['red']! * maxColorCounts['green']! * maxColorCounts['blue']!;
    print(power);
    result += power;
  }
  print('Result: $result');
}

void incrementMax(String sub, Map<String, int> maxColorCounts) {
  for (final colorGroup in sub.split(', ')) {
    final colorParts = colorGroup.split(' ');
    final count = int.parse(colorParts[0]);
    final color = colorParts[1];
    if (count > maxColorCounts[color]!) {
      maxColorCounts[color] = count;
    }
  }
}