import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bottom_navi_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        children: [MyInformation()], // FreeBoardBox(), QuestionBoardBox()
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
            margin: const EdgeInsets.symmetric(vertical: 50),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 17),
                        Text(
                          'myidddd',
                          style: TextStyle(
                            color: Color.fromARGB(255, 95, 95, 95),
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
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
