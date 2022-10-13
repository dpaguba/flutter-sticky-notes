import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notesapp/domain/loadingCircle.dart';
import 'package:notesapp/domain/textBox.dart';
import 'package:notesapp/global/color_constants.dart';
// import 'package:notesapp/domain/button.dart';
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
                    onTap: () {
                      setState(() {
                        entered = true;
                      });
                    },
                    onSubmitted: (value) {
                      print(_controller.text);
                      post();
                      _controller.clear();
                      entered = !entered;
                    },
                    cursorColor: ColorConst.gradientEnd,
                    style: const TextStyle(
                      color: ColorConst.textColor,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, color: Colors.transparent),
                      ),
                      hintText: "remind me...",
                      hintStyle: const TextStyle(
                          color: ColorConst.textColor, fontSize: 16),
                      suffixIcon: clear(),
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

  clear() {
    return entered
        ? IconButton(
            color: ColorConst.textColor,
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              entered = !entered;
            },
          )
        : null;
  }
}
