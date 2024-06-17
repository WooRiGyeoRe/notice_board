import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_1/screen/home_screen.dart';
import 'screen/bottom_navi_bar.dart'; // BottomNaviBar를 불러옵니다.
import 'screen/board_screen.dart';
import 'screen/join_screen.dart';
import 'screen/login_screen.dart';
import 'screen/profile_screen.dart';
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
    MaterialApp(
        home: //const HomeScreen(), // 홈 화면을 시작 화면으로 설정
            // const LoginScreen(),
            // const JoinScreen(),
            // const BoardScreen(),
            // const ProfileScreen(),
            const WriteScreen(),
        theme: ThemeData(fontFamily: "jeongianjeon-Regular"),
        themeMode: ThemeMode.system),
  );
}


  /*
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
*/
