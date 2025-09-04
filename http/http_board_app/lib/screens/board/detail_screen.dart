import 'package:flutter/material.dart';
import 'package:http_board_app/models/boards.dart';
import 'package:http_board_app/service/board_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // state
  String? id;                               // 게시글 id
  final boardService = BoardService();      // 게시글 서비스
  Future<Boards?>? _board;                  // 게시글 상세

  @override
  void initState() {
    super.initState();
    // id 파라미터 넘겨받기
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as String?;
      setState(() {
        id = args;
        if (id != null) {
          // 게시글 조회 요청
          _board = boardService.select(id!);
        }
      });
    });
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
        title: const Text("게시글 조회"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        child: id == null
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<Boards?>(
                future: _board,
                builder: (context, snapshot) {
                  // 로딩중
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // 에러
                  else if (snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: Text("데이터 조회 시, 에러")),
                        Center(child: Text('Error: ${snapshot.error}')),
                      ],
                    );
                  }
                  // 데이터 없음
                  else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: Text("조회된 데이터가 없습니다."));
                  }
                  // 데이터 있음
                  else {
                    final board = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.title),
                            title: Text(board.title ?? ''),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(board.writer ?? ''),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1), // 수정됨
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(2, 2),
                              )
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Text(board.content ?? ''),
                          ),
                        ),
                      ],
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
              // 수정 화면으로 이동
              Navigator.pushReplacementNamed(
                context,
                "/board/update",
                arguments: id,
              );
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
              "수정하기",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
