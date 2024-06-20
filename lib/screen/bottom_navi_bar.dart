import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    void onItemTapped(int index) {
      ref.read(selectedIndexProvider.notifier).state = index;

      // context.go() 대신 context.replace()사용하면
      // 화면 전환 애니메이션 효과 제거 가능

      /*
      switch (index) {
        case 0:
          context.replace('/');
          break;
        case 1:
          context.replace('/board', extra: 'free');
          break;
        case 2:
          context.replace('/board', extra: 'q&a');
          break;
        case 3:
          context.replace('/login');
          break;
        default:
          break;
      }
      */

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
    }

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
        unselectedLabelStyle: textStyle, // 현재 선택된 인덱스
        currentIndex: selectedIndex, // 아이템 탭될 때 콜백 함수
        onTap: onItemTapped,
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
            label: '프로필', // 로그인
          ),
        ],
      ),
    );
  }
}
