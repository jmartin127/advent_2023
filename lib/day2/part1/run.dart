import 'package:advent_2023/utils.dart';

Map<String, int> colorCounts = {'red': 12, 'green': 13, 'blue': 14};

void main(List<String> arguments) async {
  final lines = await readInput();

  int result = 0;
  await for (var line in lines) {
    print('$line');
    // Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    final gamePrefix = line.split(': ');
    final gameNum = int.parse(gamePrefix[0].split(' ')[1]);
    print(gameNum);
    final subGames = gamePrefix[1].split('; ');
    bool allPossible = true;
    for (final sub in subGames) {
      if (!isPossible(sub)) {
        allPossible = false;
      }
    }
    if (allPossible) {
      result += gameNum;
    }
  }
  print(result);
}

bool isPossible(String sub) {
  for (final colorGroup in sub.split(', ')) {
    final colorParts = colorGroup.split(' ');
    final count = int.parse(colorParts[0]);
    final color = colorParts[1];
    print('Count: $count, Bag: ${colorCounts[color]}');
    if (count > colorCounts[color]!) {
      return false;
    }
  }
  return true;
}