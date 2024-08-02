// e글 쓰기&수정
import 'package:flutter/material.dart';
import 'package:test_1/screen/comment/comment_screen.dart';

class CommentChangeScreen extends StatelessWidget {
  final String extra; // extra를 필드로 추가

  const CommentChangeScreen({
    super.key,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 오버플로우
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '댓글 수정',
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
          WriteForm(extra: extra), // extra를 WriteForm에 전달
        ],
      ),
    );
  }
}

class WriteForm extends StatefulWidget {
  final String extra;

  const WriteForm({
    super.key,
    required this.extra,
  });

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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
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
              onTapOutside: (event) => FocusManager.instance.primaryFocus
                  ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
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
          Padding(
            padding: const EdgeInsets.only(left: 20), // 여백 설정
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // 댓글을 달았던 게시물로 이동...
                      // final String board =
                      //     widget.extra == 'free Write' ? 'free' : 'q&a';
                      // context.go('/board', extra: board);
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
                    onPressed: () {
                      // context.go( );
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
