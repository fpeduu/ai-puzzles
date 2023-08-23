import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _controller = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _controller.text = "Pikachu landing in mars"; // default text
  }

  @override
  Widget build(BuildContext context) {
    final double vh = MediaQuery.of(context).size.height;
    final double vw = MediaQuery.of(context).size.width;

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
                'Send your first input!',
                style: TextStyle(color: Color(0xFFF8F1FF), fontSize: 36),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: vw * 0.8,
              child: TextField(
                controller: _controller,
                maxLength: 40,
                maxLines: 2,
                decoration: InputDecoration(
                  fillColor: Color(0xFFF8F1FF),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(color: Color(0xFF343434)),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/puzzle', arguments: {'input': _controller.text});
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
