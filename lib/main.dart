import 'package:base_flutter/demo/demo_page.dart';
import 'package:base_flutter/read_json/read_json_page.dart';
import 'package:base_flutter/rotation/rotate_page.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:html/parser.dart' show parse;
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ReadJson(),
      // home: RotatePage(),
    );
  }
}

class TextWithColor extends StatefulWidget {
  TextWithColor({Key key}) : super(key: key);

  @override
  _TextWithColorState createState() => _TextWithColorState();
}

class _TextWithColorState extends State<TextWithColor>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Color'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hello'),
            RaisedButton(onPressed: () {
              Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
                return Page1();
              },));
            }, child: Text('Jump To Page'))
            // AnimationText(_animationController),
          ]),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('on will pop');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Page 1'),
        ),
        body: Center(child: Text('page 1')),
      ),
    );
  }
}

class AnimationText extends AnimatedWidget {
  final Animation<double> animation;
  AnimationText(this.animation) : super(listenable: animation);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Hello World!',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.lerp(Colors.blue, Colors.red, animation.value))),
    );
  }
}
