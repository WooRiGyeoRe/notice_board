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
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        selectedItemColor: const Color.fromARGB(255, 129, 172, 185),
        unselectedItemColor: const Color.fromARGB(255, 158, 158, 158),
        selectedLabelStyle: textStyle,
        unselectedLabelStyle: textStyle,
        currentIndex: selectedIndex,
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
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
