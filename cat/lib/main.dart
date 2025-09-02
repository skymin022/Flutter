import 'package:cat/screens/list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutte Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        home: const ListScreen(),
    );
  }
}
