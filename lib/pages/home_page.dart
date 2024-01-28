import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Homepage();
  }
}

class _Homepage extends State<HomePage> with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;
  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);
  AnimationController? _starIconAnimationController;
  @override
  void initState() {
    super.initState();
    _starIconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 4,
      ),
    );
    _starIconAnimationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackGround(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circularAnimationButton(),
                _starIcon(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBackGround() {
    return TweenAnimationBuilder(
        tween: _backgroundScale,
        duration: Duration(seconds: 2),
        builder: (_context, _scale, _child) {
          return Transform.scale(
            scale: _scale,
            child: _child,
          );
        },
        child: Container(
          color: Colors.blue,
        ));
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: Curves.bounceInOut,
          height: _buttonRadius,
          width: _buttonRadius,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(_buttonRadius),
          ),
          child: Center(
            child: Text(
              "Basic!",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starIconAnimationController!.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _starIconAnimationController!.value * 2 * pi,
          child: _child,
        );
      },
      child: Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
