import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_1/provider/user_provider.dart';
import 'package:test_1/screen/bottom_navi_bar.dart';

class BoardContentScreen extends StatefulWidget {
  final Object extra;
  const BoardContentScreen({super.key, required this.extra});

  @override
  State<BoardContentScreen> createState() => _BoardContentScreenState();
}

class _BoardContentScreenState extends State<BoardContentScreen> {
  @override
  Widget build(BuildContext context) {
    print('======boardContent');
    print(widget.extra);
    print('======');

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.extra == 'free' ? '자유 게시판' : '질문 게시판',
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
              context.go('/board', extra: 'free');
            },
          ),
          // actions: const [],
          backgroundColor: const Color.fromARGB(255, 185, 215, 224),
          elevation: 3,
          shadowColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              BoardContentDetail(extra: widget.extra),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}

class BoardContentDetail extends StatefulWidget {
  final Object extra;
  const BoardContentDetail({super.key, required this.extra});

  @override
  State<BoardContentDetail> createState() => _BoardContentDetailState();
}

class _BoardContentDetailState extends State<BoardContentDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      // 리스트뷰??
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30), // 좌우 여백 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '글 제목',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.mode_edit,
                          color: Color.fromARGB(255, 164, 191, 199), size: 20),
                      onPressed: () {
                        String boardWrite =
                            widget.extra == 'free' ? 'free Write' : 'q&a Write';
                        context.go('/writechange', extra: boardWrite);
                        print(widget.extra);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 164, 191, 199),
                        size: 20,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                '선택한 게시물을 정말 삭제하시겠습니까?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 111, 142, 179),
                                ),
                              ),
                              content: const Text('한 번 삭제한 게시물은 복구할 수 없습니다.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // 선택된 글이 삭제된 후, 게시판 화면으로 전환
                                    context.go('/board', extra: 'free');
                                  },
                                  child: const Text(
                                    '삭제',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 134, 174, 190),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    '취소',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 160, 160, 160),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '작성날짜',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '|',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '닉네임',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const SizedBox(
                  width: double.infinity, // 전체 너비 사용
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '글 내용~~~~~~~~~~~~~~~~~~~~~~~~ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzㅋㅋㅋ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 95, 95, 95),
                        ),
                        softWrap: true, // 자동으로 줄 바꿈
                        overflow: TextOverflow.visible, // 텍스트가 넘치지 않게
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 하단 선
          const Divider(
            height: 2,
            thickness: 5, // 밑줄 두께
            color: Color.fromARGB(255, 241, 242, 243),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30), // 좌우 여백 추가
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      '댓글',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 95, 95, 95),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.mode_edit,
                          color: Color.fromARGB(255, 164, 191, 199), size: 20),
                      onPressed: () {
                        context.go('/comment');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          '닉네임',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 95, 95, 95),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          '댓글 작성 날짜',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.mode_edit,
                              color: Color.fromARGB(255, 210, 224, 228),
                              size: 20),
                          onPressed: () {
                            context.go('/commentedit');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: Color.fromARGB(255, 210, 224, 228),
                              size: 20),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    '선택한 댓글을 정말 삭제하시겠습니까?',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 111, 142, 179),
                                    ),
                                  ),
                                  content:
                                      const Text('한 번 삭제한 댓글은 복구할 수 없습니다.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        // 선택된 글이 삭제된 후, 게시판 화면으로 전환
                                        context.go('/board', extra: 'free');
                                      },
                                      child: const Text(
                                        '삭제',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 134, 174, 190),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        '취소',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 160, 160, 160),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '댓글 내용입니다아아아아아!!!ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 95, 95, 95),
                          ),
                          softWrap: true, // 자동으로 줄 바꿈
                          overflow: TextOverflow.visible, // 텍스트가 넘치지 않게
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: Color.fromARGB(255, 216, 216, 216), // 밑줄 색상
            thickness: 1, // 밑줄 두께
          ),
        ],
      ),
    );
  }
}
