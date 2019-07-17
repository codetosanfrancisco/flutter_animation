import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    boxController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
        CurvedAnimation(parent: boxController, curve: Curves.easeInOut));

    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -80.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation!'),
        ),
        body: GestureDetector(
          child: Center(
              child: Stack(
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap()
            ],
            overflow: Overflow.visible,
          )),
          onTap: onTap,
        ));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        //Child argument is passed in because we just change a small part and the animation might be 60frame/s , and we don't want to rerender 60 times a second
        return Positioned(
            child: child, top: catAnimation.value, right: 0.0, left: 0.0);
      },
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
        left: 3.0,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              angle: boxAnimation.value,
              alignment: Alignment.topLeft,
            );
          },
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
        ));
  }

  Widget buildRightFlap() {
    return Positioned(
        right: 3.0,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              child: child,
              angle: -boxAnimation.value,
              alignment: Alignment.topRight,
            );
          },
          child: Container(
            height: 10.0,
            width: 125.0,
            color: Colors.brown,
          ),
        ));
  }
}
