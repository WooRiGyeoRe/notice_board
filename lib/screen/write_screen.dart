import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// 글 쓰기&수정
class WriteScreen extends StatelessWidget {
  //final Object? extra;
  final Object extra;

  const WriteScreen({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    print('======write');
    print(extra);
    print('======');
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 오버플로우
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '글 쓰기',
          // extra == 'free' ? '자유글 작성' : '질문 작성',
          // '글 쓰기',
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 185, 215, 224), // 앱바 배경색
        elevation: 3, // 그림자 깊이
        shadowColor: Colors.black, // 앱바 그림자
      ),
      backgroundColor: Colors.white, // 전체 화면 배경색
      body: Column(
        children: [
          WriteForm(extra: extra),
        ],
      ),
    );
  }
}

class WriteForm extends StatefulWidget {
  const WriteForm({super.key, required this.extra});

  //final Object? extra;
  final Object extra;

  @override
  _WriteFormState createState() => _WriteFormState();
}

class _WriteFormState extends State<WriteForm> {
  // 제목 입력
  final TextEditingController _titleController = TextEditingController();

  // 내용 입력
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 제목
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30), // 위아래 간격 추가
            padding: const EdgeInsets.only(left: 20, right: 5), // 좌우 내부 여백 추가
            width: 372,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 196, 208, 223),
                width: 2, // 테두리 두께
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
              children: [
                Expanded(
                  // Row 내부에서 TextField를 Expanded로 감쌈
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _titleController,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '제목을 입력하세요.',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 160, 160, 160),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 내용
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15), // 좌우 내부 여백 추가
            width: 372,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 196, 208, 223),
                width: 2, // 테두리 두께
              ),
            ),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null, // 줄 바꿈
              controller: _contentController,
              style: const TextStyle(
                color: Color.fromARGB(255, 95, 95, 95),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '내용을 입력하세요.',
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
                      // (자유글쓰기->자유게시판) / (질문작성->질문게시판)
                      String board =
                          widget.extra == 'free Write' ? 'free' : 'q&a';
                      context.go('/board', extra: board);
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
                            'http://10.0.2.2:4000//api/board/free',
                            data: {
                              'title': _titleController.text,
                              'content': _contentController.text
                            });
                        print(test);
                      } catch (e) {
                        print(e);
                      }
                      print(_titleController.text);
                      print(_contentController.text);

                      // 확인 버튼 클릭 시 로직
                      String board =
                          widget.extra == 'free Write' ? 'free' : 'q&a';
                      context.go('/board', extra: board);
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
