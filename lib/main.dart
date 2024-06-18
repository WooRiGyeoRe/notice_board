import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:test_1/screen/home_screen.dart';
import 'router.dart';
import 'screen/bottom_navi_bar.dart'; // BottomNaviBar를 불러옵니다.
import 'screen/board_screen.dart';
import 'screen/comment_screen.dart';
import 'screen/home_screen.dart';
import 'screen/join_screen.dart';
import 'screen/login_screen.dart';
import 'screen/profile_screen.dart';
import 'screen/write_change_screen.dart';
import 'screen/write_screen.dart'; // LoginScreen

void main() {
  // 시스템 UI 오버레이 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 상태바 배경색을 투명하게 설정
      statusBarIconBrightness: Brightness.dark, // 상태바 아이콘을 검정색으로 설정 (안드로이드용)
      statusBarBrightness: Brightness.light, // 상태바 텍스트를 검정색으로 설정 (iOS용)
    ),
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider); // GoRouter 설정을 사용

    return MaterialApp.router(
      routerConfig: router, // GoRouter 설정 적용
      title: 'go_router',
      theme: ThemeData(fontFamily: "jeongianjeon-Regular"),
      themeMode: ThemeMode.system,
    );
  }
}




  /*
  runApp(
    MaterialApp(
      // home 대신 initialRoute를 사용하여 첫 화면을 설정합니다.
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/join': (context) => const JoinScreen(),
        '/board': (context) => const BoardScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/write': (context) => const WriteScreen(),
        '/write_change': (context) => const WriteChangeScreen(),
        '/comment': (context) => const CommentScreen(),
      },
      theme: ThemeData(fontFamily: "jeongianjeon-Regular"),
      themeMode: ThemeMode.system,
    ),
  );
}
*/

/* 기존 
  runApp(
    MaterialApp(
        home: const HomeScreen(), // 홈 화면을 시작 화면으로 설정
        // const LoginScreen(),
        // const JoinScreen(),
        // const BoardScreen(),
        // const ProfileScreen(),
        // const WriteScreen(),
        //const WriteChangeScreen(),
        //const JoinScreen(),
        // const BoardScreen(),
        // const ProfileScreen(),
        // const WriteScreen(),
        //const WriteChangeScreen(),
        theme: ThemeData(fontFamily: "jeongianjeon-Regular"),
        themeMode: ThemeMode.system),
  );
}
*/

