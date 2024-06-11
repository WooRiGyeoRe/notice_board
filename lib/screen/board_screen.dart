// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'bottom_navi_bar.dart';

class freeBoardScreen extends StatelessWidget {
  const freeBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // 앱 타이틀 설정
          title: const Row(
            children: [
              Icon(Icons.chat_bubble, color: Colors.white, size: 30),
              SizedBox(width: 15), // 아이콘과 텍스트 사이의 간격 조절
              Text(
                '자유 게시판',
                style: TextStyle(
                    fontFamily: "jeongianjeon-Regular",
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 15),
              Icon(Icons.chat_bubble,
                  color: Color.fromARGB(255, 158, 158, 158), size: 17),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 185, 215, 224), // 앱바 배경색
          elevation: 3, // 그림자 깊이
          shadowColor: Colors.black), // 앱바 그림자
      backgroundColor: Colors.white, // 전체 화면 배경색
      body: const Column(
          // children: [LoginForm()],
          ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}
