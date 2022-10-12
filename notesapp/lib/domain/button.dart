import 'package:flutter/material.dart';
import 'package:notesapp/global/color_constants.dart';

class Button extends StatelessWidget {
  final text;
  final function;

  const Button({
    this.text,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: ColorConst.emphasized,
            child: Text(
              text,
              style: const TextStyle(
                color: ColorConst.textColor,
                fontFamily: "Lobster",
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
