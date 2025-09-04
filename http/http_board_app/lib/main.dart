import 'package:flutter/material.dart';
import 'package:http_board_app/screens/board/create_screen.dart';
import 'package:http_board_app/screens/board/detail_screen.dart';
import 'package:http_board_app/screens/board/list_screen.dart';
import 'package:http_board_app/screens/board/update_screen.dart';
import 'package:http_board_app/screens/main_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "http board app",
      initialRoute: '/main',
      routes: { 
        '/main'         : (context) => const MainScreen(),
        '/boards/list'   : (context) => const ListScreen(),
        '/boards/create' : (context) => const CreateScreen(),
        '/boards/detail' : (context) => const DetailScreen(),
        '/boards/update' : (context) => const UpdateScreen(),
      },
    );
  }
}
