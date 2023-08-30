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
  List<Image> images = [];
  bool isLoading = false;
  List<int> directions = List.generate(9, (index) => Random().nextInt(4));

  void rotateImage(int imgIndex) {
    setState(() {
      directions[imgIndex] = (directions[imgIndex] + 1) % 4;
    });
  }

  @override
  void initState() {
    super.initState();
    loadImages();
    // Mock API call and image loading
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 2)).then((_) {
      setState(() {
        images = [
          Image.asset('assets/image1.jpg'),
          Image.asset('assets/image2.jpg'),
          //... other images
        ];
        isLoading = false;
      });
    });
  }

  Future<void> loadImages() async {
    setState(() {
      isLoading = true;
    });

    // final String apiKey = "yYTIEoz3kXHQBvIIXRI8TojE7bqUcw8mAzELOJUcx1UuFdoRz5sI8BSdMVFB";
    // final String url = "https://stablediffusionapi.com/api/v3/text2img";
    //
    // final response = await http.post(
    //   Uri.parse(url),
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode({
    //     "key": apiKey,
    //     "prompt": widget.input,
    //     "width": 512,
    //     "height": 512,
    //   }),
    // );

    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> data = json.decode(response.body);
    //   // Assuming 'output' contains the image URLs
    //   final List<String> imageUrls = List<String>.from(data['output']);
    //
    //   setState(() {
    //     images = imageUrls.map((url) => Image.network(url)).toList();
    //     isLoading = false;
    //   });
    // } else {
    //   print('Failed to load images');
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF343434),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Here's your puzzle!",
              style: TextStyle(
                  fontSize: 36, color: Color(0xFFF8F1FF)),
            ),
            Image.asset('lib/assets/prompt-result.png'),
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
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => rotateImage(index),
                  child: RotatedBox(
                    quarterTurns: directions[index],
                    child: images.length > index
                        ? images[index]
                        : Placeholder(),
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

void main() {
  runApp(
    MaterialApp(
      home: PuzzlePage(input: "Pikachu landing on Mars"),
    ),
  );
}


// import 'package:flutter/material.dart';
//
// class PuzzlePage extends StatefulWidget {
//   final String input;
//
//   PuzzlePage({required this.input});
//
//   @override
//   _PuzzlePageState createState() => _PuzzlePageState();
// }
//
// class _PuzzlePageState extends State<PuzzlePage> {
//   late List<Image> images = [];
//   bool isLoading = true;
//   List<int> directions = List.generate(9, (index) => (index % 4));
//
//   @override
//   void initState() {
//     super.initState();
//     loadImages();
//   }
//
//   Future<void> loadImages() async {
//     // Here you would do the API call and image manipulation.
//     // Once the images are loaded and manipulated, you can set them to the images list and update the isLoading flag.
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   void rotateImage(int imgIndex) {
//     // Handle image rotation logic here.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double vh = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Color(0xFF343434),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator(color: Color(0xFFF8F1FF))
//             : Column(
//                 children: [
//                   Text(
//                     "Here's your puzzle!",
//                     style: TextStyle(color: Color(0xFFF8F1FF), fontSize: 36),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Tap on a piece to rotate it.\nPrompt: "${widget.input}"',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Color(0xFFF8F1FF), fontSize: 20),
//                   ),
//                   // You'll dynamically create the Image widgets based on the images list and set up tap handlers to rotate them.
//                   // This is just a placeholder.
//                   ...images.map((image) => GestureDetector(
//                         onTap: () => rotateImage(images.indexOf(image)),
//                         child: image,
//                       ))
//                 ],
//               ),
//       ),
//     );
//   }
// }
