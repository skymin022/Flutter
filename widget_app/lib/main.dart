
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}



// stf : StatefulWidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // state
  String _menu = '점메추';
  final _menuList = ['짜장', '짬뽕', '볶음밥', '김치찌개', '된장찌개'];

  void _random() { 
    final r = Random().nextInt(_menuList.length);
    // State Update
    setState(() {
      _menu = _menuList[r];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          title: Text('My App'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: Center(
          child: Text(
                    _menu,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue
                    ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _random();
          },
          child: const Icon(Icons.restaurant_menu),
        ),
      ),
    );
  }
}






// stl : StatelessWidget

// class MyApp extends StatelessWidget {
//   // 생성자
//   const MyApp({super.key});

//   // 메소드 오버라이딩
//   // build 메소드 
//   // : 위젯 트리를 반환 
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp( 
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
//           title: Text('My App'),
//           actions: [
//             IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
//           ],
//         ),
//         body : Center(
//           child: 
//           Text('Hello World!')
//           ),
//           // bottomNavigationBar: BottomAppBar(
//           //   color : Colors.lightBlue,
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: [
//           //       Column(
//           //         children: [
//           //           IconButton(
//           //             onPressed: () {},
//           //             icon: const Icon(Icons.home),
//           //       ),
//           //       const Text("Home")
//           //         ],
//           //       )
//           //       ,
//           //       Column(
//           //         children: [
//           //           IconButton(
//           //             onPressed: () {},
//           //             icon: const Icon(Icons.shopping_cart),
//           //       ),
//           //       const Text("Cart")
//           //         ],
//           //       ),
//           //       Column(
//           //         children: [
//           //           IconButton(
//           //             onPressed: () {},
//           //             icon: const Icon(Icons.person),
//           //       ),
//           //       const Text("Profile")
//           //         ],
//           //       )
                
//           //     ],
//           //   )
//           // ),
//           bottomNavigationBar:BottomNavigationBar(
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home'
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.shopping_cart),
//                 label: 'Cart'
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile'
//               ),

//             ])
//       ),
//     );
//   }
// }