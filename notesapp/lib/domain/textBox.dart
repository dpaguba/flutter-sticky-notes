import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String text;

  TextBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.grey[700],
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
