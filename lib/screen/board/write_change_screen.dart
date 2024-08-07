import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// 글 쓰기&수정
class WriteChangeScreen extends StatelessWidget {
  final String extra; // extra를 필드로 추가

  const WriteChangeScreen({
    super.key,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false, // 키보드 오버플로우
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             Icon(Icons.mode_edit, color: Colors.white, size: 30),
//             SizedBox(width: 15), // 아이콘과 텍스트 사이의 간격 조절
//             Text(
//               '글 수정',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 35,
//                   fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         backgroundColor: const Color.fromARGB(255, 185, 215, 224), // 앱바 배경색
//         elevation: 3, // 그림자 깊이
//         shadowColor: Colors.black, // 앱바 그림자
//       ),
//       backgroundColor: Colors.white, // 전체 화면 배경색
//       body: const Column(
//         children: [
//           WriteForm(),
//         ],
//       ),
//     );
//   }
// }
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 오버플로우
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '글 수정',
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
                    onTapOutside: (event) => FocusManager.instance.primaryFocus
                        ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
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
                      final String board =
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
                    onPressed: () {
                      context.go('/board', extra: 'free');
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
