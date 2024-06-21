import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'bottom_navi_bar.dart';

// 자유&질문 게시판
class BoardScreen extends StatelessWidget {
  final Object extra;

  const BoardScreen({
    super.key,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
    print('======board');
    print(extra);
    print('======');

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: const SingleChildScrollView(
        child: Column(
          children: [Page()],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// 페이지 이동 , 검색 창 만들기...
class Page extends StatefulWidget {
  const Page({super.key});

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    // 게시판 검색 변수
    final TextEditingController contentFindController = TextEditingController();

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 650),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  width: 200,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: contentFindController,
                    textAlignVertical: TextAlignVertical.center, // 상하 중앙 정렬
                    onTapOutside: (event) => FocusManager.instance.primaryFocus
                        ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 239, 239, 239),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none, // 테두리 제거
                      ),
                      //포커스 됐을 때 스타일 설정
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 5),
                ),
                SizedBox(
                  height: 45,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: () {
                      // 검색 버튼 눌렀을 때 로직
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          const Color.fromARGB(255, 196, 208, 223), // 글자색
                      textStyle: const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    child: const Text(
                      '검색',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "jeongianjeon-Regular",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
