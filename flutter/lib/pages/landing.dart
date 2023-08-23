import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Make sure to add flutter_svg to your pubspec.yaml

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF343434),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Positioned(
              top: vh * 0.1,
              child: Text(
                'AI Puzzles',
                style: TextStyle(color: Color(0xFFF8F1FF), fontSize: 36),
              ),
            ),
            Positioned(
              top: vh * 0.2,
              child: Text(
                'Create your own puzzle within the reach of a touch',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFF8F1FF), fontSize: 20),
              ),
            ),
            SizedBox(height: 20),
            SvgPicture.network(
              'https://svgur.com/i/vbS.svg',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/input');
              },
              child: Text('Get started'),
            ),
          ],
        ),
      ),
    );
  }
}
