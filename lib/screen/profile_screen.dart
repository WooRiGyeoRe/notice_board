import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'bottom_navi_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          // 앱 타이틀 설정
          title: const Row(
            children: [
              Icon(Icons.person, color: Colors.white, size: 30),
              SizedBox(width: 15), // 아이콘과 텍스트 사이의 간격 조절
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
          SizedBox(height: 80),
          LogOutButton(),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

// 개인 정보
class MyInformation extends StatefulWidget {
  const MyInformation({super.key});

  @override
  _MyInformationState createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
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

            child: const Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 위젯의 children 사이의 간격을 조정
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 60, //imageSize,
                      color: Color.fromARGB(255, 158, 158, 158),
                      //color: Color.fromARGB(255, 198, 213, 228),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '닉네임',
                          style: TextStyle(
                              color: Color.fromARGB(255, 95, 95, 95),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 17),
                        Text(
                          'myidddd',
                          style: TextStyle(
                            color: Color.fromARGB(255, 95, 95, 95),
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // SizedBox(width: 50),
                Icon(
                  Icons.mode_edit,
                  size: 25, //imageSize,
                  color: Color.fromARGB(255, 134, 174, 190),
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
class LogOutButton extends StatefulWidget {
  const LogOutButton({super.key});

  @override
  _LogOutButtonState createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 372,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // 로그아웃 버튼이 눌렸을 때 처리할 로직을 추가하세요.
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
                  // '회원 탈퇴하기' 텍스트를 탭했을 때 처리할 로직을 추가
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
