import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/domain/loadingCircle.dart';
import 'package:notesapp/domain/textBox.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/global/color_constants.dart';
import 'package:notesapp/domain/button.dart';
import 'package:notesapp/services/google_sheets_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  void loadNotes() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!GoogleSheetsApi.loading) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until data is received
    if (GoogleSheetsApi.loading) {
      setState(() {
        loadNotes();
      });
    }

    return Scaffold(
      backgroundColor: ColorConst.wBackground,
      body: Column(children: [
        Expanded(
          child: GoogleSheetsApi.loading
              ? const LoadingCircle()
              : Expanded(
                  child: GridView.builder(
                    itemCount: GoogleSheetsApi.currentNotes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, index) {
                      return TextBox(text: GoogleSheetsApi.currentNotes[index]);
                    },
                  ),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    text: "R E D",
                    function: () {
                      print(_controller.text);
                      post();
                      setState(() {});
                    },
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
  post() {
    GoogleSheetsApi.insert(_controller.text);
  }
}
