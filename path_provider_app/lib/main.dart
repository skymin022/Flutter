import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Memo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // state
  List<String> _itemList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    List<String> savedItemList = await readMemo();
    print(savedItemList);
    setState(() {
      _itemList = savedItemList;
    });
  }

  // 메모 불러오는 함수
  Future<List<String>> readMemo() async {
    List<String> itemList = [];

    var dir = await getApplicationDocumentsDirectory();
    var filePath = '${dir.path}/memo.txt';
    var file = File(filePath);

    bool fileExist = await file.exists();

    if (!fileExist) {
      print("최초로 memo.txt 파일 생성");
      await file.writeAsString('');
    }

    String content = await file.readAsString();

    if (content.isEmpty) {
      return [];
    }

    var array = content.split('\n');
    for (var item in array) {
      if (item.isNotEmpty) {
        itemList.add(item);
      }
    }
    return itemList;
  }

  // 메모 저장하는 함수
  Future<void> writeMemo(String data) async {
    var dir = await getApplicationDocumentsDirectory();
    var filePath = '${dir.path}/memo.txt';
    var file = File(filePath);

    String content = await file.readAsString();
    if (content.isEmpty) {
      content = data;
    } else {
      content = '$content\n$data';
    }

    await file.writeAsString(content);
  }

  // 메모 삭제하는 함수
  Future<bool> deleteMemo(int index) async {
    List<String> copyList = List.from(_itemList);
    copyList.removeAt(index);

    var fileData = copyList.join('\n');

    var dir = await getApplicationDocumentsDirectory();
    var filePath = '${dir.path}/memo.txt';
    var file = File(filePath);

    await file.writeAsString(fileData);

    setState(() {
      _itemList = copyList;
    });
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Center(
          child: Column(
            children: [
              // 메모 입력
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "메모 입력해주세요",
                  ),
                ),
              ),

              const SizedBox(height: 10.0, ),

              // 메모 리스트
              Expanded(
                child: ListView.builder(
                  itemCount: _itemList.length,
                  itemBuilder: (context, index){ 
                    return GestureDetector(
                      onLongPress: () async {
                        print("카드 길게 누름");
                        bool check = await deleteMemo(index);
                        if ( check ) { 
                          setState(() {
                            _itemList.removeAt(index);
                          });
                        }
                      },
                      child: Card(
                        child: Center(
                          child: Text(_itemList[index], 
                          style: TextStyle(fontSize: 20.0),),
                        ),
                        ),
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("메모 등록");
          // 입력한 메모를 txt 파일에 저장 
          writeMemo(_controller.text);
          // 입력한 내용을 itemList에 추가 
          setState(() {
          _itemList.add(_controller.text);
          });
          // 텍스트 필드에 입력한 내용 비우기
          _controller.text = "";
        }, 
        child: Icon(Icons.create),
        ),
    );
  }
}
