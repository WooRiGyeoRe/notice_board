import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0; // 현재 선택된 인덱스를 저장하는 상태 변수

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 아이템 탭될 때 상태 업데이트

      switch (index) {
        case 0:
          context.go('/');
          break;
        case 1:
          context.go('/board', extra: 'free');
          break;
        case 2:
          context.go('/board', extra: 'q&a');
          break;
        case 3:
          context.go('/login');
          break;
        default:
          break;
      }
    });
  }

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
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        onTap: _onItemTapped, // 아이템 탭될 때 콜백 함수
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
            icon: Icon(Icons.person),
            label: '프로필', // '로그인'
          ),
        ],
      ),
    );
  }
}
