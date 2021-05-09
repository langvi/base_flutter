import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatePage extends StatefulWidget {
  RotatePage({Key key}) : super(key: key);

  @override
  _RotatePageState createState() => _RotatePageState();
}

class _RotatePageState extends State<RotatePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 5000))
          ..repeat(period: Duration(milliseconds: 500));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: Column(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                  angle: _animationController.value * 2 * math.pi,
                  child: child);
            },
            child: FlutterLogo(
              size: 200,
            ),
          ),
          // RotationTransition(
          //   turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
          //   child: Icon(
          //     Icons.star,
          //     color: Colors.yellow,
          //     size: 40,
          //   ),
          // ),
          RaisedButton(
            onPressed: () {
             
              // _animationController.forward(from: 0.0);
            },
            child: Text('start'),
          ),
          RaisedButton(
            onPressed: () {
              _animationController.stop();
            },
            child: Text('stop'),
          ),
        ],
      ),
    );
  }
}
