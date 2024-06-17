import 'package:flutter/material.dart';

// 글 쓰기&수정
class WriteScreen extends StatelessWidget {
  const WriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.mode_edit, color: Colors.white, size: 30),
              SizedBox(width: 15), // 아이콘과 텍스트 사이의 간격 조절
              Text(
                '글 쓰기',
                style: TextStyle(
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
      // resizeToAvoidBottomInset: false, // 키보드 오버플로우 해결
      body: const Column(
        children: [],
      ),
      // bottomNavigationBar: const BottomBar(),
    );
  }
}

// class WriteForm extends StatefulWidget {
//   const WriteForm({super.key});
// }
