import 'package:flutter/material.dart';
import '../widgets/cat.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    catAnimation = Tween(begin: 0.0, end: 100.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation!'),
        ),
        body: GestureDetector(
          child: buildAnimation(),
          onTap: () {
            catController.forward();
          },
        ));
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        //Child argument is passed in because we just change a small part and the animation might be 60frame/s , and we don't want to rerender 60 times a second
        return Container(
            child: child, margin: EdgeInsets.only(top: catAnimation.value));
      },
      child: Cat(),
    );
  }
}
