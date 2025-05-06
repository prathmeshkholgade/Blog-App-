import 'package:flutter/material.dart';

class TextLogo extends StatelessWidget {
  const TextLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Flutter",
        style: TextStyle(fontSize: 22, color: Colors.white),
        children: [
          TextSpan(
            text: "Blog",
            style: TextStyle(fontSize: 22, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
