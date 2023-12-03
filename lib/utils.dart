import 'dart:convert';
import 'dart:io';

Future<Stream<String>> readInput() async {
  final file = File('input.txt');
    Stream<String> lines = file.openRead()
    .transform(utf8.decoder)       
    .transform(LineSplitter()); 
  return lines;
}