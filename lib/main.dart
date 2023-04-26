import 'package:flutter/material.dart';
import 'package:nopte_app_example_shared_preferences/new.dart';

import 'note_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo Uz',
      theme: ThemeData(
        // useMaterial3: true,
      ),
      home:  NoteListScreen(),
    );
  }
}
