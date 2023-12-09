import 'dart:convert';
import 'dart:io';

List<String> readInutLines() {
  final file = File('input.txt');
  return file.readAsLinesSync();
}

Future<Stream<String>> readInput() async {
  final file = File('input.txt');
    Stream<String> lines = file.openRead()
    .transform(utf8.decoder)       
    .transform(LineSplitter()); 
  return lines;
}