import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:convert';
// import 'package:http/http.dart' as http;

class PuzzlePage extends StatefulWidget {
  final String input;
  PuzzlePage({required this.input});

  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {

  // List<Image> images = [];
  // bool isLoading = false;
  List<int> directions = List.generate(9, (index) => Random().nextInt(4));

  void rotateImage(int imgIndex) {
    setState(() {
      directions[imgIndex] = (directions[imgIndex] + 1) % 4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF343434),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Here's your puzzle!",
              style: TextStyle(
                  fontSize: 36, color: Color(0xFFF8F1FF)),
            ),
            // Image.asset('lib/assets/prompt-result.png'),
            Text(
              'Tap on a piece to rotate it.\nPrompt: "${widget.input}"',
              style: TextStyle(
                  fontSize: 20, color: Color(0xFFF8F1FF)),
              textAlign: TextAlign.center,
            ),
            GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int x = index % 3;
                  int y = (index / 3).floor();
                  return GestureDetector(
                    onTap: () => rotateImage(index),
                    child: RotatedBox(
                      quarterTurns: directions[index],
                      child: Stack(
                        children: [
                          Positioned(
                            left: -x * (MediaQuery.of(context).size.width / 3),
                            top: -y * (MediaQuery.of(context).size.width / 3),
                            child: Image.asset(
                              'lib/assets/prompt-result.png',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover
                            ),
                          )
                        ],
                      ),
                      // child: ClipPath(
                      //   clipper: ImagePieceClipper(x, y),
                      //   child: Transform.translate(
                      //       offset: Offset(-x * (MediaQuery.of(context).size.width / 3),
                      //                       -y * (MediaQuery.of(context).size.width / 3)),
                      //     child: Image.asset('lib/assets/prompt-result.png',
                      //         width: MediaQuery.of(context).size.width / 3,
                      //         height: MediaQuery.of(context).size.width / 3,
                      //         fit: BoxFit.cover),
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class ImagePieceClipper extends CustomClipper<Path> {
  final int x;
  final int y;

  ImagePieceClipper(this.x, this.y);

  @override
  Path getClip(Size size) {
    final pieceWidth = size.width / 3;
    final pieceHeight = size.height / 3;
    return Path()
        ..addRect(Rect.fromLTWH(x * pieceWidth, y * pieceHeight, pieceWidth, pieceHeight))
        ..close();
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

void main() {
  runApp(
    MaterialApp(
      home: PuzzlePage(input: "Pikachu landing on Mars"),
    ),
  );
}
