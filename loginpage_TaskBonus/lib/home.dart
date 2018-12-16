import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
 static String tag = 'home-page';
  @override
  _HomePageState createState() => new _HomePageState();

}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  bool _loadingInProgress;

  Animation<double> _angleAnimation;

  Animation<double> _scaleAnimation;

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;
      _controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _angleAnimation = new Tween(begin: 0.0, end: 360.0).animate(_controller)
      ..addListener(() {
        setState(() {

        });
      });
    _scaleAnimation = new Tween(begin: 1.9, end: 2.0).animate(_controller)
      ..addListener(() {
        setState(() {
         
        });
      });
 
    _angleAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_loadingInProgress) {
          _controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (_loadingInProgress) {
          _controller.forward();
        }
      }
    });
 
    _controller.forward();
  }

    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context)
  {
    final logo = Hero
    (
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
   return Scaffold
    (
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          children: <Widget>[
            logo,
            SizedBox(height: 20.0),
            Container(child: _buildBody())
          ],
        ),
      ),
    );
  }

  Widget _buildBody() 
  {
    if (_loadingInProgress) 
    {
      return new Center(
        child: Container
        (
          width:20.0,
          
          child:
            (
              _buildAnimation()
            )
        )
      );
    } else {
      return new Center (
        child: new Text('Data loaded'),
      );
    }
  }

    Widget _buildAnimation() 
    {
    double circleWidth = 5.0 * _scaleAnimation.value;
    Widget circles = new Container
    (
      width: circleWidth * 2.0,
      height: circleWidth * 2.0,
      child: new Column
      (
        children: <Widget>
        [
          new Row 
          (
              children: <Widget>
              [
                _buildCircle(circleWidth,Colors.lightBlueAccent.shade200),
                _buildCircle(circleWidth,Colors.blue.shade400),
              ],
          ),
          new Row 
          (
            children: <Widget>
            [
              _buildCircle(circleWidth,Colors.blue.shade400),
              _buildCircle(circleWidth,Colors.lightBlueAccent.shade200),
            ],
          ),
        ],
      ),
    );
 
    double angleInDegrees = _angleAnimation.value;
    return new Transform.rotate(
      angle: angleInDegrees / 360 * 2 * pi,
      child: new Container
      (
        child: circles,
      ),
    );
  }
 
  Widget _buildCircle(double circleWidth, Color color) {
    return new Container
    (
      width: circleWidth,
      height: circleWidth,
      decoration: new BoxDecoration
      (
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}