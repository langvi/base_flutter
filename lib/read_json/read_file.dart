import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<void> writeFile(Map<String, dynamic> data) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  File file = File('$path/language.txt');
  file.writeAsString(data.toString());
  print('writed success');
}

Future<void> readFile() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  File file = File('$path/language.txt');
  String data = await file.readAsString();
  print(data);
}
