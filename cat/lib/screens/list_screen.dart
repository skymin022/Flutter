import 'package:cat/models/cat.dart';
import 'package:cat/screens/detail_screen.dart';
import 'package:cat/screens/upload_screen.dart';
import 'package:flutter/material.dart';

final List<Cat> cats = [
  // 임시 데이터 
  Cat(
    id: "0",
    name: "test1",
    title: "title1",
    link: "assets/images/cat_00.png",
    likeCount: 1000,
    replyCount: 6,
    created: DateTime(2025, 11, 13, 22, 14, 25, 900), 
  ),
  Cat(
    id: "1",
    name: "test2",
    title: "title2",
    link: "assets/images/cat_01.png",
    likeCount: 100,
    replyCount: 60,
    created: DateTime(2024, 10, 13, 22, 14, 25, 900), 
  ),
  Cat(
    id: "2",
    name: "test3",
    title: "title3",
    link: "assets/images/cat_02.png",
    likeCount: 10,
    replyCount: 600,
    created: DateTime(2023, 9, 13, 22, 14, 25, 900), 
  ),
  Cat(
    id: "3",
    name: "test4",
    title: "title4",
    link: "assets/images/cat_03.png",
    likeCount: 1,
    replyCount: 6000,
    created: DateTime(2022, 8, 13, 22, 14, 25, 900), 
  ),
  Cat(
    id: "4",
    name: "test5",
    title: "title5",
    link: "assets/images/cat_04.png",
    likeCount: 10000,
    replyCount: 60000,
    created: DateTime(2021, 7, 13, 22, 14, 25, 900), 
  ),
  Cat(
    id: "5",
    name: "test6",
    title: "title6",
    link: "assets/images/cat_05.png",
    likeCount: 10000,
    replyCount: 60000,
    created: DateTime(2021, 7, 13, 22, 14, 25, 900), 
  ),
  Cat(
    id: "6",
    name: "test7",
    title: "title7",
    link: "assets/images/cat_06.png",
    likeCount: 10000,
    replyCount: 60000,
    created: DateTime(2021, 7, 13, 22, 14, 25, 900), 
  ),
  
  

];

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Cats"),
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (_) => const UploadScreen());
          }, icon: const Icon(Icons.camera_alt))
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 10.0,
          right: 10.0
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1.0
          ),
          itemCount: cats.length,
          itemBuilder: (_, int index) => GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailScreen(cat: cats[index])));
            },
            child: Image.asset(
              cats[index].link,
              fit: BoxFit.cover,
            ),
          ),
        ),
    );
  }
}