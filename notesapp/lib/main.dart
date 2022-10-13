import 'package:flutter/material.dart';
import 'package:notesapp/global/color_constants.dart';
import 'package:notesapp/screens/home.dart';
import 'package:notesapp/services/google_sheets_api.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Open Sans",
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Reminders",
            style: TextStyle(
              fontSize: 34,
              fontFamily: "Lobster",
              color: ColorConst.textColor,
            ),
          ),
          elevation: 0,
          backgroundColor: ColorConst.emphasized,
        ),
        body: const HomePage(),
      ),
    );
  }
}
