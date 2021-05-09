import 'package:base_flutter/read_json/read_file.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:translator/translator.dart';

class ReadJson extends StatefulWidget {
  ReadJson({Key key}) : super(key: key);

  @override
  _ReadJsonState createState() => _ReadJsonState();
}

class _ReadJsonState extends State<ReadJson> {
  String data = '';
  final translator = GoogleTranslator();
  Map<String, dynamic> dataLanguage = Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read file Jsons'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(data),
            RaisedButton(
              onPressed: () {
                getDataFromFileJson();
              },
              child: Text('Get'),
            ),
            RaisedButton(
              onPressed: () async {
                print('start write');
                await writeFile(dataLanguage);
                 print('end write');
              },
              child: Text('Write'),
            ),
            RaisedButton(
              onPressed: () async {
                print('start read');
                await readFile();
              },
              child: Text('Read'),
            ),
          ]),
    );
  }

  void getDataFromFileJson() async {
    Map<String, dynamic> dmap = await parseJsonFromAssets('assets/vi.json');
    List<String> values = [];
    List<String> keys = [];
    List<String> valuesConvert = [];
    dmap.forEach((key, value) {
      keys.add(key);
      values.add(value);
    });
    for (int i = 0; i < values.length; i++) {
      String result = await translate(values[i]);
      valuesConvert.add(result);
    }
    for (int index = 0; index < values.length; index++) {
      dataLanguage.putIfAbsent(
          '"${keys[index]}"', () => '"${valuesConvert[index]}"');
    }
    print(data.toString());
  }

  Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
    return rootBundle
        .loadString(assetsPath)
        .then((jsonStr) => jsonDecode(jsonStr));
  }

  Future<String> translate(String value) async {
    var str = await translator.translate(value, from: 'vi', to: 'ko');
    String result = str.text;
    return result.replaceAll(RegExp(r' '), '');
  }
}
