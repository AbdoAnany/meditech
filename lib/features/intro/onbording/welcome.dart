import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../home/presentation/pages/home_screen.dart';

// Animated Painter that appears at the start screen


/// The [WelcomePage] widget is the first page that is shown to the user
/// consists of delayed, intertwined animations

class WelcomePage extends StatefulWidget {
  static const String route = "/WelcomePage";
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late Animation buttonAnimation,
      textAnimation,
      painterAnimation,
      positionAnimation,
      fadeTextAnimation;

  late double height, width;
  bool showWelcomeText = false;

  @override
  void initState() {
    initializeAnimations();
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  void initializeAnimations() {
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 2, milliseconds: 500));

    painterAnimation =
        Tween<double>(begin: 0.0, end: 12.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.25, 0.5, curve: Curves.easeInOut),
        ));

    textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.4, 0.6, curve: Curves.easeInOut),
    ));

    positionAnimation =
        Tween<double>(begin: 0.5, end: 0.3).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.625, 0.7, curve: Curves.easeInOut),
        ));

    fadeTextAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 0.8, curve: Curves.easeInOut),
        ));
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if( fadeTextAnimation.value == 0.0)
        HomeScreen(),
          CustomPaint(
            painter: WelcomePainter(painterAnimation.value),
            child: Stack(
              children: [
                textAnimation.value > 0.0 ? _buildWelcomeText() : Container(),
                fadeTextAnimation.value > 0
                    ? _buildDetailTextAndButton(context)
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildDetailTextAndButton(BuildContext context) {
    return Positioned(
      top: 0.4 * height,
      left: 0.15 * width,
      right: 0.15 * width,
      child: Opacity(
        opacity: fadeTextAnimation.value,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'welcomeMessage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.05 * height),
            GestureDetector(
              onTap: () {
                controller.reverse().then(
                      (value) {
                    // Navigator.of(context)
                    //     .pushReplacementNamed(NavigatorPage.route);
                  },
                );
              },
              child: Container(
                height: 0.06 * height,
                width: 0.5 * width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white.withOpacity(0.25)),
                child: Center(
                  child: Text(
                    "Let's start",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildWelcomeText() {
    return Positioned(
      top: positionAnimation.value * height,
      left: 0,
      right: 0,
      child: Opacity(
        opacity: textAnimation.value,
        child: Container(
          child: Center(
            child: Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w900,
                fontSize: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class WelcomePainter extends CustomPainter {
  double ratio = 1;

  WelcomePainter(this.ratio);
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width;
    double y = size.height;

    Path path = new Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(x * 0.4, (y * 0.25) * ratio, x, (y * 0.275) * ratio)
      ..lineTo(x, 0)
      ..lineTo(0, 0)
      ..close();

    Path path2 = new Path()
      ..moveTo(0, 0)
      ..moveTo(0, y)
      ..lineTo(x, y)
      ..lineTo(x, y * 0.8)
      ..quadraticBezierTo(x * 0.5, (y * 0.6) / ratio, 0, (y * 0.675) / ratio)
      ..lineTo(0, y)
      ..close();

    const Color color1 = Color(0xFF713FFE);
    const Color color2 = Color(0xFF9B38FE);

    Paint paint1 = new Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(0, y * 0.275),
        [
          // Color(0xFFf17568),
          // Color(0xFFe67b6e),
          color1, color2,
        ],
      );

    Paint paint2 = new Paint()
      ..shader = ui.Gradient.linear(
        Offset(x, y),
        Offset(0, y * 0.675),
        [
          color2, color1,
          // Color(0xFFe67b6e),
          // Color(0xFFe94c3d),
        ],
      );

    canvas.drawPath(path, paint1);

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}