import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: "jeongianjeon-Regular",
      fontSize: 13,
    );
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2, // 그림자의 확산 정도
            blurRadius: 8, // 그림자의 흐림 정도
            offset: const Offset(0, 3), // 그림자의 위치 (x는 수평, y는 수직)
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        selectedItemColor: const Color.fromARGB(255, 129, 172, 185), // 선택된 요소 색
        unselectedItemColor:
            const Color.fromARGB(255, 158, 158, 158), // 선택되지 않은 요소 색
        selectedLabelStyle: textStyle,
        unselectedLabelStyle: textStyle,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: '자유',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: '질문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // 프로필을 나타내는 아이콘으로 변경
            label: '프로필', // '로그인'
          ),
        ],
        // BottomNavigationBar 아이템이 선택되었을 때 처리할 로직을 정의합니다.
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/board');
              break;
            case 2:
              Navigator.pushNamed(context, '/comment');
              break;
            case 3:
              Navigator.pushNamed(context, '/login');
              break;
          }
        },
      ),
    );
  }
}
