import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router.dart';
import 'dart:convert'; // JSON Encode, Decode를 위한 패키지
import 'screen/bottom_navi_bar.dart';
import 'screen/board_screen.dart';
import 'screen/comment_screen.dart';
import 'screen/home_screen.dart';
import 'screen/join_screen.dart';
import 'screen/login_screen.dart';
import 'screen/profile_screen.dart';
import 'screen/write_change_screen.dart';
import 'screen/write_screen.dart';

void main() async {
  // 상태바 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 상태바 배경색을 투명하게 설정
      statusBarIconBrightness: Brightness.light, // 상태바 아이콘을 검정색으로 설정 (안드로이드용)
      statusBarBrightness: Brightness.light, // 상태바 텍스트를 검정색으로 설정 (iOS용)
    ),
  );

  // 앱 시작될 때 키보드 자동 숨기기
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // SharedPreferences 인스턴스 생성

  // setter- shared preferences에 데이터 저장
  // await 변수명.set자료형(키, 밸류);

  // getter-shared preferences에서 데이터 불러오기
  // 자료형? 변수명 = SharedPreferences인스턴스.get자료형(키);

  // delete-shared preferences에 존재하는 데이터 삭제하기
  // await SharedPreferences인스턴스.remove(키);

  // ProviderScope -> 프로바이더를 작동할 수 있게하는 위젯
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
    final router = ref.watch(routerProvider);
    //final authUser = ref.watch(authProvider);

    return MaterialApp.router(
      routerConfig: router, // GoRouter 설정 적용
      title: 'go_router',
      theme: ThemeData(fontFamily: "jeongianjeon-Regular"),
      themeMode: ThemeMode.system,
    );
  }
}



 

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

