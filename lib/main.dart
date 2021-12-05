import 'package:flutter/material.dart';

import 'homepage.dart';
import 'on_board.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title : 'COVID-19 Tracker',
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: OnBoard(),
    );
  }
}
