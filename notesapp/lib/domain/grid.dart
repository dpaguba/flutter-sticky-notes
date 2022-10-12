// import 'package:flutter/material.dart';
// import 'package:notesapp/services/google_sheets_api.dart';

// class GridNotes extends StatelessWidget {
//   final String text;
//   final int numberOfNotes;

//   GridNotes({
//     required this.text,
//     required this.numberOfNotes,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GridView.builder(
//           itemCount: GoogleSheetsApi.numberOfNotes,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 4),
//           itemBuilder: (BuildContext context, int index) {
//             return Container(child: TextBox(text: GoogleSheetsApi.currentNotes[index]),);
//           }),
//     );
//   }
// }
