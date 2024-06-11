import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'bottom_navi_bar.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // 앱 타이틀 설정
          title: const Row(
            children: [
              Icon(Icons.person_add, color: Colors.white, size: 30),
              SizedBox(width: 15), // 아이콘과 텍스트 사이의 간격 조절
              Text(
                '회원가입',
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
        children: [JoinForm()],
      ),
      // bottomNavigationBar: const BottomBar(),
    );
  }
}

class JoinForm extends StatefulWidget {
  const JoinForm({super.key});

  @override
  _JoinFormState createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 50),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: '아이디',
              labelStyle: TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Color.fromARGB(255, 95, 95, 95),
                fontSize: 20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 196, 208, 223),
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: '닉네임',
              labelStyle: TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Color.fromARGB(255, 95, 95, 95),
                fontSize: 20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 196, 208, 223),
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: '비밀번호',
              labelStyle: TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Color.fromARGB(255, 95, 95, 95),
                fontSize: 20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 196, 208, 223),
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: '비밀번호 확인',
              labelStyle: TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Color.fromARGB(255, 95, 95, 95),
                fontSize: 20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 196, 208, 223),
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              // 로그인 버튼이 눌렸을 때 처리할 로직을 추가하세요.
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 196, 208, 223),
              textStyle: const TextStyle(
                fontFamily: "jeongianjeon-Regular",
                fontSize: 25,
              ),
            ),
            child: const Text(
              '회원가입',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                '이미 회원이신가요?',
                style: TextStyle(
                  fontFamily: "jeongianjeon-Regular",
                  fontSize: 14,
                  color: Color.fromARGB(255, 160, 160, 160),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // '로그인' 텍스트를 탭했을 때 처리할 로직을 추가
                },
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    fontFamily: "jeongianjeon-Regular",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 134, 174, 190),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
