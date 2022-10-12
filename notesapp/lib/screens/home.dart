import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/domain/loadingCircle.dart';
import 'package:notesapp/domain/textBox.dart';
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
  bool entered = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
  }

  void loadNotes() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
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
      backgroundColor: ColorConst.background,
      body: Column(
        children: [
          Expanded(
            child: GoogleSheetsApi.loading
                ? const LoadingCircle()
                : GridView.builder(
                    itemCount: GoogleSheetsApi.currentNotes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (BuildContext context, index) {
                      return TextBox(text: GoogleSheetsApi.currentNotes[index]);
                    },
                  ),
          ),
          Container(
            color: ColorConst.emphasized,
            padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).size.height / 30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      entered = _controller.text.isNotEmpty ? true : false;
                    },
                    onSubmitted: (value) {
                      print(_controller.text);
                      post();
                      _controller.clear();
                    },
                    style: const TextStyle(color: ColorConst.textColor),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent),
                      ),
                      hintText: "enter ...",
                      suffixIcon: switchIcons(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // functions
  post() {
    GoogleSheetsApi.insert(_controller.text);
  }

  switchIcons() {
    return entered
        ? IconButton(
            color: ColorConst.textColor,
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              entered = !entered;
            },
          )
        : IconButton(
            color: Colors.transparent,
            icon: const Icon(Icons.add),
            onPressed: () {
              _controller.clear();
            },
          );
  }
}
