import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/global/color_constants.dart';
import 'package:notesapp/domain/button.dart';
import '';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.wBackground,
      body: Column(children: [
        Expanded(
          child: Container(
            color: Colors.grey[700],
          ),
        ),
        Container(
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    hintText: "enter ...",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                      },
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                    text: "R E M I N D",
                    // function: _remind(),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }

  // functions

  void _remind() {
    print(_controller.text);
  }
}
