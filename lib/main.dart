import 'package:flutter/material.dart';
import 'package:sqfliteapp/screens/note_screen.dart';
import 'package:sqfliteapp/screens/noteslist_screen.dart';
import 'sql_helper.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Sqlite',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const NoteScreenList());
  }
}
