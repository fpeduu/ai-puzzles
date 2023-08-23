import 'package:flutter/material.dart';

class PuzzlePage extends StatefulWidget {
  final String input;

  PuzzlePage({required this.input});

  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  late List<Image> images;
  bool isLoading = true;
  List<int> directions = List.generate(9, (index) => (index % 4));

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    // Here you would do the API call and image manipulation.
    // Once the images are loaded and manipulated, you can set them to the images list and update the isLoading flag.
    setState(() {
      isLoading = false;
    });
  }

  void rotateImage(int imgIndex) {
    // Handle image rotation logic here.
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF343434),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(color: Color(0xFFF8F1FF))
            : Column(
                children: [
                  Text(
                    "Here's your puzzle!",
                    style: TextStyle(color: Color(0xFFF8F1FF), fontSize: 36),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tap on a piece to rotate it.\nPrompt: "${widget.input}"',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFFF8F1FF), fontSize: 20),
                  ),
                  // You'll dynamically create the Image widgets based on the images list and set up tap handlers to rotate them.
                  // This is just a placeholder.
                  ...images.map((image) => GestureDetector(
                        onTap: () => rotateImage(images.indexOf(image)),
                        child: image,
                      ))
                ],
              ),
      ),
    );
  }
}
