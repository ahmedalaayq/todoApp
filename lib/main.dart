import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/views/todo_view.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: '${GoogleFonts.alexandria}',
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: TodoView(),
    );
  }
}
