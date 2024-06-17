// 앱 기본 화면(메인 화면)
// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_1/main.dart';
import 'bottom_navi_bar.dart';

// 앱바 구현하기
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱바 위제 추가
      appBar: AppBar(
          // 앱 타이틀 설정
          title: const Text(
            'Talk tok',
            style: TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 185, 215, 224), // 앱바 배경색
          elevation: 3, // 그림자 깊이
          shadowColor: Colors.black), // 앱바 그림자
      backgroundColor: Colors.white, // 전체 화면 배경색
      body: const Column(
        children: [FreeBoardBox(), QuestionBoardBox()],
      ),
      bottomNavigationBar: const BottomBar(),
      /*
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '검색',
          ),
        ],
      ), 
      */
    );
  }
}

// 자유게시판
class FreeBoardBox extends StatefulWidget {
  const FreeBoardBox({super.key});

  @override
  _FreeBoardBoxState createState() => _FreeBoardBoxState();
}

class _FreeBoardBoxState extends State<FreeBoardBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30), // 위아래 간격 추가
          height: 247,
          width: 372,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 242, 247),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color.fromARGB(255, 224, 235, 247)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Column 자식들 왼쪽 정렬
            children: [
              const SizedBox(height: 15), // 간격 추가
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '자유게시판',
                        style: TextStyle(
                            fontFamily: "jeongianjeon-Regular",
                            color: Color.fromARGB(255, 95, 95, 95),
                            fontSize: 30),
                        textAlign: TextAlign.left, // 텍스트를 왼쪽으로 정렬
                      ),
                      GestureDetector(
                        onTap: () {
                          // 더보기 버튼을 눌렀을 때의 동작 추가
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 50), // 오른쪽 여백 추가
                          child: const Text(
                            '더보기',
                            style: TextStyle(
                                fontFamily: "jeongianjeon-Regular",
                                color: Color.fromARGB(255, 124, 167, 175),
                                fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // 추가 컨테이너와의 간격 추가
              Container(
                height: 40, // 추가 컨테이너 높이 설정
                width: 352,
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft, // 텍스트를 상하 중앙으로 정렬
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 242, 247),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 196, 208, 223)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  '점메추 부탁드립니다~',
                  style: TextStyle(
                      fontFamily: "jeongianjeon-Regular",
                      color: Color.fromARGB(255, 95, 95, 95),
                      fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                width: 352,
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 242, 247),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 196, 208, 223)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  '오늘 날씨가 좋네요!',
                  style: TextStyle(
                      fontFamily: "jeongianjeon-Regular",
                      color: Color.fromARGB(255, 95, 95, 95),
                      fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                width: 352,
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 230, 242, 247),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 196, 208, 223)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  '다들 여름 휴가 어디로 가시나용?',
                  style: TextStyle(
                      fontFamily: "jeongianjeon-Regular",
                      color: Color.fromARGB(255, 95, 95, 95),
                      fontSize: 20),
                ),
              ),
            ],
          )),
    );
  }
}

// 질문게시판
class QuestionBoardBox extends StatefulWidget {
  const QuestionBoardBox({super.key});

  @override
  _QuestionBoardBoxState createState() => _QuestionBoardBoxState();
}

class _QuestionBoardBoxState extends State<QuestionBoardBox> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 50), // 위아래 간격 추가
        height: 247,
        width: 372,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 230, 242, 247),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color.fromARGB(255, 224, 235, 247)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Column 자식들 왼쪽 정렬
          children: [
            const SizedBox(height: 15), // 간격 추가
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '질문게시판',
                      style: TextStyle(
                          fontFamily: "jeongianjeon-Regular",
                          color: Color.fromARGB(255, 95, 95, 95),
                          fontSize: 30),
                      textAlign: TextAlign.left, // 텍스트를 왼쪽으로 정렬
                    ),
                    GestureDetector(
                      onTap: () {
                        // 더보기 버튼 눌렀을 때 동작 추가
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: const Text(
                          '더보기',
                          style: TextStyle(
                              fontFamily: "jeongianjeon-Regular",
                              color: Color.fromARGB(255, 124, 167, 175),
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // 추가 컨테이너와의 간격 추가
            Container(
              height: 40, // 추가 컨테이너 높이 설정
              width: 352,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft, // 텍스트를 상하 중앙으로 정렬
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 242, 247),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: const Color.fromARGB(255, 196, 208, 223)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                '질문1',
                style: TextStyle(
                    fontFamily: "jeongianjeon-Regular",
                    color: Color.fromARGB(255, 95, 95, 95),
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              width: 352,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 242, 247),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: const Color.fromARGB(255, 196, 208, 223)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                '질문2',
                style: TextStyle(
                    fontFamily: "jeongianjeon-Regular",
                    color: Color.fromARGB(255, 95, 95, 95),
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              width: 352,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 230, 242, 247),
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: const Color.fromARGB(255, 196, 208, 223)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                '질문3',
                style: TextStyle(
                    fontFamily: "jeongianjeon-Regular",
                    color: Color.fromARGB(255, 95, 95, 95),
                    fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
