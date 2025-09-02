import 'package:basic_widget/example/icon_widget.dart';
import 'package:basic_widget/example/image_widget.dart';
import 'package:basic_widget/example/safearea_widget.dart';
import 'package:basic_widget/example/text_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기본 위젯',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('기본 위젯'),
          centerTitle: true,
        ),
        body: 
          // TextWidget()
          // ImageWidget()
          // IconWidget()
          SafeareaWidget()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
