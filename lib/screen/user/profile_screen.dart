// 프로필 스크린
// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/provider/user_provider.dart';
import 'package:test_1/screen/bottom_navi_bar.dart';
import 'package:test_1/service/user_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          // 앱 타이틀 설정
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '프로필',
                style: TextStyle(
                    fontFamily: "jeongianjeon-Regular",
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 185, 215, 224), // 앱바 배경색
          elevation: 3, // 그림자 깊이
          shadowColor: Colors.black), // 앱바 그림자
      backgroundColor: Colors.white, // 전체 화면 배경색
      body: const Column(
        children: [
          SizedBox(height: 50),
          MyInformation(),
          SizedBox(height: 25),
          MyBoard1(), // 자유게시판 글, 댓글
          SizedBox(height: 25),
          MyBoard2(), // 질문게시판 글, 댓글
          SizedBox(height: 50),
          LogOutButton(),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// 개인 정보
class MyInformation extends ConsumerStatefulWidget {
  const MyInformation({super.key});

  @override
  _MyInformationState createState() => _MyInformationState();
}

class _MyInformationState extends ConsumerState<MyInformation> {
  // final bool _nickValid = true;
  // final bool _newNick = false;

  final RegExp _newNickRegex = RegExp(
    // 영문 소문자, 숫자, 한글만 허용하고 특수문자, 숫자, 공백은 불가능
    r'^[a-z가-힣0-9]+$',
    caseSensitive: false,
  );

  // 딱 한 번만 실행되는 함수
  // 가장 먼저 실행됨.
  // 뭔가를 초기화할 때 주로 쓰임.
  // 리스너 등록할 때 JS의 addEventListender();
  @override
  void initState() {
    super.initState();
    // 프로필 화면이 로드될 때 사용자 정보 갱신
    ref.read(userAsyncProvider.notifier).getToken();
  }

  // 이 페이지가 언마운트될 때 = 사라질 때 실행되는 함수
  // removeListner;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // 수평으로 가운데 정렬
        children: [
          Container(
            // margin: const EdgeInsets.symmetric(vertical: 50),
            width: 372,
            height: 97,
            decoration: BoxDecoration(
              //color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color.fromARGB(255, 224, 235, 247),
                width: 2, // width 테두리 두께
              ),
            ),
            alignment: Alignment.centerLeft, // 아이콘 왼쪽 정렬
            padding:
                const EdgeInsets.only(left: 25, right: 25), // 왼쪽과 오른쪽에 여백 추가

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 위젯의 children 사이의 간격을 조정
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 60, //imageSize,
                      color: Color.fromARGB(255, 158, 158, 158),
                      //color: Color.fromARGB(255, 198, 213, 228),
                    ),
                    const SizedBox(width: 15),
                    ref.watch(userAsyncProvider).when(
                        data: (data) {
                          // null 체크 및 기본값 제공
                          final String nick = data['nick'] ?? '닉네임 없음';
                          final String id = data['id'] ?? '아이디 없음';
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data['nick'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 95, 95, 95),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 17),
                              Text(
                                data['id'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 95, 95, 95),
                                  fontSize: 13,
                                ),
                              )
                            ],
                          );
                        },
                        error: (error, stackTrace) {
                          print(error);
                          return Container();
                        },
                        loading: () => const CircularProgressIndicator()),
                  ],
                ),
                IconButton(
                  onPressed: () // async
                      {
                    print('닉네임 수정 아이콘 클릭===========');
                    final TextEditingController nickController =
                        TextEditingController();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            '닉네임 수정',
                            style: TextStyle(
                              color: Color.fromARGB(255, 111, 142, 179),
                            ),
                          ),
                          content: TextField(
                            controller: nickController,
                            decoration: const InputDecoration(
                                hintText: '수정할 닉네임을 입력해주세요.'),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                '확인',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 134, 174, 190),
                                ),
                              ),
                              onPressed: () async {
                                final newNick = nickController.text.trim();
                                if (newNick.isNotEmpty) {
                                  if (!_newNickRegex.hasMatch(newNick)) {
                                    Navigator.of(context)
                                        .pop(); // AlertDialog 닫기
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 161, 180, 204),
                                        content: Text(
                                            '닉네임은 한글 또는 영어 소문자, 숫자 한 글자 이상이어야 합니다.'),
                                      ),
                                    );
                                    return;
                                  }

                                  // 사용자 정보를 업데이트하는 메서드 호출
                                  try {
                                    await ref
                                        .read(userAsyncProvider.notifier)
                                        .updateNick(newNick);

                                    // 서버에서 닉네임 업데이트 시도
                                    print('닉네임 변경 성공===========');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 161, 180, 204),
                                        content: Text('닉네임이 성공적으로 변경되었습니다.'),
                                      ),
                                    );
                                  } catch (e) {
                                    // 서버 업데이트 실패
                                    print('닉네임 업데이트 중 오류 발생: $e');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 161, 180, 204),
                                        content:
                                            Text('이미 사용 중인 닉네임입니다. 다시 입력해주세요.'),
                                      ),
                                    );
                                  }
                                } else {
                                  Navigator.of(context).pop(); // AlertDialog 닫기
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 161, 180, 204),
                                      content: Text('닉네임을 입력해 주세요.'),
                                    ),
                                  );
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text(
                                '취소',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 160, 160, 160),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.mode_edit,
                    size: 25,
                    color: Color.fromARGB(255, 134, 174, 190),
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

// 자유게시판
class MyBoard1 extends StatefulWidget {
  const MyBoard1({super.key});

  @override
  _MyBoardState1 createState() => _MyBoardState1();
}

class _MyBoardState1 extends State<MyBoard1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 수직으로 가운데 정렬
        children: [
          Container(
            width: 372,
            height: 146,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color.fromARGB(255, 224, 235, 247), width: 2),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    '자유 게시판',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Text(
                              '게시글',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 170, 170, 170),
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '10',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 95, 95, 95),
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 50,
                        thickness: 1.5,
                        color: Color.fromARGB(255, 219, 219, 219),
                      ),
                      Column(
                        children: [
                          Text(
                            '댓글',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 170, 170, 170),
                            ),
                          ),
                          Text(
                            '15',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 95, 95, 95),
                            ),
                          ),
                        ],
                      ),
                    ],
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

// 질문게시판
class MyBoard2 extends StatefulWidget {
  const MyBoard2({super.key});

  @override
  _MyBoardState2 createState() => _MyBoardState2();
}

class _MyBoardState2 extends State<MyBoard2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 수직으로 가운데 정렬
        children: [
          Container(
            width: 372,
            height: 146,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color.fromARGB(255, 224, 235, 247), width: 2),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    '질문 게시판',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 95, 95, 95),
                    ),
                  ),
                ),
                SizedBox(height: 7),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Column(
                          children: [
                            Text(
                              '게시글',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 170, 170, 170),
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              '7',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 95, 95, 95),
                              ),
                            ),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        width: 50,
                        thickness: 1.5,
                        color: Color.fromARGB(255, 219, 219, 219),
                      ),
                      Column(
                        children: [
                          Text(
                            '댓글',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 170, 170, 170),
                            ),
                          ),
                          Text(
                            '12',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 95, 95, 95),
                            ),
                          ),
                        ],
                      ),
                    ],
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

// 로그아웃, 탈퇴
class LogOutButton extends ConsumerStatefulWidget {
  const LogOutButton({super.key});

  @override
  _LogOutButtonState createState() => _LogOutButtonState();
}

class _LogOutButtonState extends ConsumerState<LogOutButton> {
  final LogoutService _logoutService = LogoutService(); // LogoutService 사용 준비
  final WithdrawalService _withdrawalService = WithdrawalService();

  Future<void> _handleWithdrawal() async {
    const String userId = 'user_id'; // 실제 사용자 ID로 변경
    const String userPassword = 'user_password'; // 실제 사용자 비밀번호로 변경
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 372,
          height: 50,
          child: ElevatedButton(
            onPressed: () async {
              print('로그아웃 버튼 눌러보기');

              // 토큰 유효성 검사

              //if (token != null) {
              try {
                await LogoutService().logout();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        '로그아웃 성공',
                        style: TextStyle(
                          color: Color.fromARGB(255, 111, 142, 179),
                        ),
                      ),
                      content: const Text('로그아웃 되었습니다.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            '확인',
                            style: TextStyle(
                              color: Color.fromARGB(255, 111, 142, 179),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
                context.go('/'); // 로그아웃 버튼 눌렀을 때
              } catch (e) {
                print(e);
                if (e is DioException) {
                  // 토큰 없음 혹은 위조, 만료
                  if (e.response?.statusCode == 401) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white, // 다이얼로그 배경색
                          title: const Text(
                            '로그아웃 실패',
                            style: TextStyle(
                              color: Color.fromARGB(255, 111, 142, 179),
                            ),
                          ),
                          content:
                              const Text('로그아웃을 위한 인증이 만료되었습니다. 다시 로그인해주세요.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                              child: const Text(
                                '확인',
                                style: TextStyle(
                                  color: Color.fromARGB(
                                      255, 111, 142, 179), // 버튼 텍스트 색상
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white, // 다이얼로그 배경색
                          title: const Text(
                            '서버 오류가 발생했습니다.',
                            style: TextStyle(
                              color: Color.fromARGB(255, 111, 142, 179),
                            ),
                          ),
                          content: const Text('로그아웃을 다시 진행해주세요.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // 다이얼로그 닫기
                              },
                              child: const Text(
                                '확인',
                                style: TextStyle(
                                  color: Color.fromARGB(
                                      255, 111, 142, 179), // 버튼 텍스트 색상
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              }
              //}
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 196, 208, 223),
            ),
            child: const Text(
              '로그아웃',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20), // 왼쪽 여백 추가
          child: Row(
            children: [
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  print('회원 탈퇴 쪽입니다');
                  // '회원 탈퇴하기' 텍스트를 탭했을 때 처리할 로직을 추가
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: const Text(
                            '정말 탈퇴하시겠어요?',
                            style: TextStyle(color: Colors.red),
                          ),
                          content:
                              const Text('탈퇴 버튼 선택 시, 계정은 삭제되며 복구되지 않습니다.'),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  //onPressed: _handleWithdrawal, // 탈퇴 처리 함수 호출
                                  onPressed: () async {
                                    // SharedPreferences에서 사용자 정보 삭제
                                    await WithdrawalService().withdrawal();

                                    Navigator.of(context).pop();
                                    // context.go('/');

                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                              '탈퇴가 완료되었습니다.',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 111, 142, 179),
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  context.go('/');
                                                },
                                                child: const Text(
                                                  '확인',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 111, 142, 179),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text(
                                    '탈퇴',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                // 취소 버튼 선택 시
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    context.go('/profile');
                                  },
                                  child: const Text(
                                    '취소',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 111, 142, 179),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      });
                },
                child: const Text(
                  '회원 탈퇴하기',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 134, 174, 190),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
