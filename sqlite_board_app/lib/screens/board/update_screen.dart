import 'package:flutter/material.dart';
import 'package:sqlite_board_app/models/boards.dart';
import 'package:sqlite_board_app/service/board_service.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String? id;                               // 게시글 id
  final boardService = BoardService();      // 게시글 서비스
  Future<Boards?>? _board;                  // 게시글 상세

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _writerController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as String?;
      if (args != null) {
        setState(() {
          id = args;
          _getData(id!);
        });
      }
    });
  }

  // 게시글 조회 요청
  Future<void> _getData(String id) async {
    Boards? board = await boardService.select(id);
    if (board != null) {
      setState(() {
        _board = Future.value(board);
        _titleController.text = board.title ?? "";
        _writerController.text = board.writer ?? "";
        _contentController.text = board.content ?? "";
      });
    } else {
      print("보낼 데이터 없음");
    }
  }

  // 게시글 수정 요청
  Future<void> update() async {
    if (!_formKey.currentState!.validate()) {
      print("게시글 입력 정보가 유효하지 않음");
      return;
    }
    Boards board = Boards(
      id: id, 
      title: _titleController.text,
      writer: _writerController.text,
      content: _contentController.text,
    );

    int result = await boardService.update(board);
    if (result > 0) {
      print("게시글 수정 성공");
      Navigator.pushReplacementNamed(context, '/board/list');
    } else {
      print("게시글 수정 실패");
    }
  }

    // 팝업메뉴 아이템 (수정하기, 삭제하기)
  final List<PopupMenuEntry<String>> _popupMenuItems = [
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, size: 16),
                                        SizedBox(width: 8),
                                        Text('삭제하기'),
                                      ],
                                    ),
                                  ),
                                ];

  // 삭제 확인
  Future<bool> _confirm() async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("삭제 확인"),
          content: const Text("정말 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () {
                result = true;
                Navigator.of(context).pop(true);
              },
              child: const Text("삭제"),
            ),
          ],
        );
      }
    ).then((value) {
      // [삭제], [취소]
      result = value ?? false;
    });
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/board/list');
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Text("게시글 수정"),
        actions: [PopupMenuButton(
          itemBuilder: (BuildContext context) { 
            return _popupMenuItems;
          },
          onSelected: (String value) async { 
            // 삭제하기 클릭 시
            if ( value == 'delete') { 
              // 삭제 확인 ➡ 삭제 처리
              bool check = await _confirm();
              if ( check ) { 
                // 삭제 처리 
                int result = await boardService.delete(id!);
                if (result > 0) { 
                  print("게시글 삭제 성공");
                  // 게시글 목록으로 이동 
                  Navigator.pushReplacementNamed(context, '/board/list');
              } else { 
                print("게시글 삭제 실패");
              }
            }
          }
          })
        ]
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: id == null
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<Boards?>(
                future: _board,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("데이터 조회 시, 에러"),
                        Text('Error: ${snapshot.error}'),
                      ],
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text("조회된 데이터가 없습니다."));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _titleController,
                              decoration: const InputDecoration(labelText: "제목"),
                              validator: (value) =>
                                  value == null || value.isEmpty ? "제목 입력하세요" : null,
                            ),
                            TextFormField(
                              controller: _writerController,
                              decoration: const InputDecoration(labelText: "작성자"),
                              validator: (value) =>
                                  value == null || value.isEmpty ? "작성자 입력하세요" : null,
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _contentController,
                              decoration: const InputDecoration(
                                labelText: "내용",
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              validator: (value) =>
                                  value == null || value.isEmpty ? "내용 입력하세요" : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: () { 
              update();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              "등록하기",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
