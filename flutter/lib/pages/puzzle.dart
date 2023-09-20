import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PuzzlePage extends StatefulWidget {
  final String input;
  PuzzlePage({Key? key, required this.input}) : super(key: key);

  static PuzzlePage fromRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
    final String input = args['input'] as String;
    return PuzzlePage(input: input);
  }

  @override
  _PuzzlePageState createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {

  // List<Image> images = [];
  // bool isLoading = false;
  List<int> directions = List.generate(9, (index) => Random().nextInt(4));
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  Future<void> fetchImage() async {
    const apiKey = "eBpl35wn6SwTuKF9X1M3RT7fVy1R1uaxVN2T3aPaPlJOV3h89EZLYVAzJF5O";
    const url = "https://stablediffusionapi.com/api/v3/text2img";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'key': apiKey,
          'prompt': widget.input,
          'width': 512,
          'height': 512
        })
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          imageUrl = jsonResponse['output'][0].replaceAll('\\', '');
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void rotateImage(int imgIndex) {
    setState(() {
      directions[imgIndex] = (directions[imgIndex] + 1) % 4;
      if (isPuzzleCompleted()) {
        // Delay the execution by 1 second
        Future.delayed(Duration(seconds: 2), () {
          // Show a dialog to inform the user that they've completed the puzzle
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Congratulations!"),
              content: Text("You've completed the puzzle!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);  // Close the AlertDialog
                    Navigator.pop(context);  // Navigate back to the initial page
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          );
        });
      }
    });
  }




  bool isPuzzleCompleted() {
    return directions.every((direction) => direction == 0);
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
                          if (imageUrl != null)
                            Positioned(
                              left: -x * (MediaQuery.of(context).size.width / 3),
                              top: -y * (MediaQuery.of(context).size.width / 3),
                              child: Image.network(
                                imageUrl!,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            if (index == 4) Center(child: CircularProgressIndicator()),
                        ],
                      ),
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
