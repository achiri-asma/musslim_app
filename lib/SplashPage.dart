import 'package:flutter/material.dart';
import 'dart:async';

import 'FirstScreen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<Offset> _imageOffsetAnimation;
  late AnimationController _textController;
  late Animation<Offset> _textOffsetAnimation;

  late GlobalKey<ScaffoldState> _scaffoldKey;



  @override
  void initState() {
    super.initState();

    _scaffoldKey = GlobalKey<ScaffoldState>();

    // Initialize animation controller for image
    _imageController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Initialize offset animation for image
    _imageOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeInOut,
    ));

    // Initialize animation controller for text
    _textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Initialize offset animation for text
    _textOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    // Start the animations when the widget is built
    _imageController.forward();
    _textController.forward();

    // Add a delay and navigate to the second screen
    Future.delayed(Duration(seconds: 10), () {
      // Use the GlobalKey context
      Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => FirstScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _imageOffsetAnimation,
                  child: Image.asset(
                    "lib/assets/images/logo.jpg",
                    // Add any additional properties to the Image widget
                  ),
                ),
                SizedBox(height: 16.0),
                SlideTransition(
                  position: _textOffsetAnimation,
                  child: Text(
                    'دليل المسلم الصغير ',
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _imageController.dispose();
    _textController.dispose();
    super.dispose();
  }
}
