import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_1/provider/user_provider.dart';
import 'bottom_navi_bar.dart';

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
          // if ()
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
                      IconButton(
                        icon: const Icon(Icons.delete,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 20),
                        onPressed: () {
                          // context.go('/board'); // 선택된 글이 삭제된 후, 게시판 화면으로 전환
                          context.go('/comment');
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
            children: [Search()],
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
                      hintStyle: WidgetStateProperty.all(
                        const TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158)),
                      ),
                      trailing: const [
                        Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 136, 159, 163),
                        ),
                      ],
                      backgroundColor: const WidgetStatePropertyAll(
                          Color.fromARGB(255, 239, 242, 245)),
                      shadowColor: const WidgetStatePropertyAll(
                          Color.fromARGB(255, 226, 226, 226)),
                      elevation: const WidgetStatePropertyAll(3),
                      // constraints: BoxConstraints(maxWidth: 300, maxHeight: 100), 크기 설정
                      shape: WidgetStateProperty.all(ContinuousRectangleBorder(
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
