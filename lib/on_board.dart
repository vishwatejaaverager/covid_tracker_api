import 'package:covid/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class OnBoard extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        }, finishCallback: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      },
      ),
    );
  }
  final pages = [
    PageModel(
        color:  Colors.black87,
        imageAssetPath: 'images/hh.jpg',
        title: 'Welcome',
        body: 'covid tracking app',
        doAnimateImage: true),
    PageModel(
        color:  Colors.black,
        imageAssetPath: 'images/ll.jpg',
        title: 'covid tracking',
        body: 'get instant updates',
        doAnimateImage: true),
  ];
}
