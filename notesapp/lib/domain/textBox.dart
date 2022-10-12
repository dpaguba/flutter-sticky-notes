import 'package:flutter/material.dart';
import 'package:notesapp/global/color_constants.dart';

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
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                ColorConst.gradientStart,
                ColorConst.gradientEnd,
              ])),
          child: Center(
            child: Text(
              text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                color: ColorConst.emphasized,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
