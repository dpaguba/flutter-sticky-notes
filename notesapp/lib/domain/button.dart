import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Button extends StatelessWidget {
  final String text;
  // final function;
  const Button({
    super.key,
    required this.text,
    // required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: function,
      child: Container(
        padding: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.pink,
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
