import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/provider/user_provider.dart';
import 'package:test_1/screen/bottom_navi_bar.dart';

import 'package:test_1/service/freeboard_service.dart';

// 자유&질문 게시판
class BoardScreen extends ConsumerWidget {
  final Object extra;
  //final bool authUser; // 회원 여부

  const BoardScreen({
    super.key,
    required this.extra,
    //required this.authUser,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('======board');
    print(extra);
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
            ref.watch(userAsyncProvider).maybeWhen(
              data: (data) {
                if (data['token'] == null) {
                  return Container();
                } else {
                  return Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.mode_edit,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 20),
                        onPressed: () {
                          String boardWrite =
                              extra == 'free' ? 'free Write' : 'q&a Write';
                          context.go('/write',
                              extra: boardWrite); // boardWrite 변수 자체를 전달
                        },
                      ),
                    ],
                  );
                }
              },
              orElse: () {
                return Container();
              },
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 185, 215, 224),
          elevation: 3,
          shadowColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: const SingleChildScrollView(
          child: Column(
            children: [Search(), BoardContent()],
          ),
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }
}

//검색 창 만들기...
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
              padding: EdgeInsets.only(top: 30),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 40,
                    // 검색창 위젯 기본 제공
                    child: SearchBar(
                      controller: contentFindController,
                      hintText: '검색어를 입력하세요 : ) ',
                      hintStyle: MaterialStateProperty.all(
                        const TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158)),
                      ),
                      trailing: const [
                        Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 136, 159, 163),
                        ),
                      ],
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 239, 242, 245)),
                      shadowColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 226, 226, 226)),
                      elevation: const MaterialStatePropertyAll(3),
                      // constraints: BoxConstraints(maxWidth: 300, maxHeight: 100), 크기 설정
                      shape: MaterialStateProperty.all(
                          ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
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

// 데이터 가져오기가 살짝 느림...!
class BoardContent extends StatefulWidget {
  const BoardContent({super.key});

  @override
  State<BoardContent> createState() => _BoardContentState();
}

class _BoardContentState extends State<BoardContent> {
  // final FreeBoardListService _freeBoardListService = FreeBoardListService();

  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final service = FreeBoardListService();
    try {
      data = await service.freeboardList(1);
      print('Data loaded: $data');
      for (final el in data) {
        print(el);
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building BoardContent');
    print('Data count: ${data.length}');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: SizedBox(
          // height: 100,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color.fromARGB(255, 216, 216, 216),
                  style: BorderStyle.solid,
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Color.fromARGB(255, 216, 216, 216),
                  style: BorderStyle.solid,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
                // ListView.builder
                ListView.separated(
                  // padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    color: Color.fromARGB(255, 216, 216, 216),
                  ),
                  itemBuilder: (context, index) {
                    // if (data.isEmpty) {
                    //   return Container();
                    // }
                    final board = data[index];
                    DateTime date = DateTime.parse(board['createdAt']);
                    final createAt = DateFormat('yy.MM.dd').format(date);
                    return InkWell(
                      onTap: () {
                        context.go(
                          '/boardcontent',
                          extra: {
                            'board': 'free',
                            'no': board['no'],
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      board['title'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 95, 95, 95),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    // ElevatedButton(
                                    //     onPressed: () {
                                    //       context.go('/boardcontent',
                                    //           extra: 'free');
                                    //     },
                                    //     child: const Text('게시물보기')),
                                    const SizedBox(width: 10),
                                    if (board['commentCount'] > 0)
                                      Text(
                                        '[${board['commentCount']}]',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 137, 190, 197),
                                        ),
                                      ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  createAt,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  '|',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  board['nick'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
