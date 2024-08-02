import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../bottom_navi_bar.dart';

// 글 쓰기&수정
class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 오버플로우
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '댓글 쓰기',
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 185, 215, 224), // 앱바 배경색
        elevation: 3, // 그림자 깊이
        shadowColor: Colors.black, // 앱바 그림자
      ),
      backgroundColor: Colors.white, // 전체 화면 배경색
      body: const Column(
        children: [
          WriteForm(
            extra: '',
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class WriteForm extends StatefulWidget {
  const WriteForm({super.key, required String extra});

  @override
  _WriteFormState createState() => _WriteFormState();
}

class _WriteFormState extends State<WriteForm> {
  // 내용 입력
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 내용
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15), // 좌우 내부 여백 추가
            width: 372,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 196, 208, 223),
                width: 2, // 테두리 두께
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              onTapOutside: (event) => FocusManager.instance.primaryFocus
                  ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
              maxLines: null, // 줄 바꿈
              controller: _contentController,
              style: const TextStyle(
                color: Color.fromARGB(255, 95, 95, 95),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '댓글을 입력하세요.',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 160, 160, 160),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20), // 여백 설정
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .go('/board'); // 게시판 첫화면보다는 댓글을 쓴 게시물로 돌아가는 걸로 바꾸도록~
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 196, 208, 223),
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final dio = Dio();
                        final test = await dio.post(
                            'http://10.0.2.2:4000//api/comment/free',
                            data: {
                              // "boardNo":
                              'content': _contentController.text,
                            });
                        print(test);
                      } catch (e) {
                        print(e);
                      }
                      print(_contentController.text);
                      // print(boardNo);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 196, 208, 223),
                    ),
                    child: const Text(
                      '확인',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
