import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'bottom_navi_bar.dart';

// 자유&질문 게시판
class BoardScreen extends StatelessWidget {
  const BoardScreen({
    super.key,
    required this.extra,
  });

  final Object extra;

  @override
  Widget build(BuildContext context) {
    print('======board');
    print(extra);
    print('======');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          extra == 'free' ? '자유 게시판' : '질문 게시판',
          style: const TextStyle(
            fontFamily: "jeongianjeon-Regular",
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.mode_edit,
                    color: Color.fromARGB(255, 255, 255, 255), size: 20),
                onPressed: () {
                  String boardWrite =
                      extra == 'free' ? 'free Write' : 'q&a Write';
                  context.go('/write',
                      extra: boardWrite); // boardWrite 변수 자체를 전달
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete,
                    color: Color.fromARGB(255, 255, 255, 255), size: 20),
                onPressed: () {
                  // context.go('/board'); // 선택된 글이 삭제된 후, 게시판 화면으로 전환
                  context.go('/comment');
                },
              ),
            ],
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 185, 215, 224),
        elevation: 3,
        shadowColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: const Column(
          // children: [LoginForm()],
          ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
