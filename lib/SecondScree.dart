import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String widgetName;
  final String widgetImage;
  final String widgetNumber;
  const SecondScreen({Key? key, required this.widgetName,required this.widgetImage,required this.widgetNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$widgetName'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '$widgetImage',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 16.0),
            Text(
              '$widgetName ',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'عدد ركعات صلاة الصبح   $widgetNumber  ',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}