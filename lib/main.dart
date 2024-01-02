import 'package:flutter/material.dart';
import 'package:getx_hive_project/database_function/db_functions.dart';
import 'package:getx_hive_project/models/notes.dart';
import 'package:getx_hive_project/pages/home_page.dart';
import 'package:getx_hive_project/pages/notes_screen.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await DbFunctions.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NoteScreen(),
    );
  }
}
