import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_navi_bar.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('======profile');
    print('login');
    print('======');
    // Scaffold 레이아웃 위젯 중 하나로, 앱의 기본 구조를 정의
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '로그인',
          style: TextStyle(
            fontFamily: "jeongianjeon-Regular",
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/');
          },
        ),
        backgroundColor: const Color.fromARGB(255, 185, 215, 224),
        shadowColor: Colors.black,
        elevation: 3,
      ),
      backgroundColor: Colors.white,
      body: const Column(
        children: [LoginForm()],
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // 아이디 초기화 변수
  final TextEditingController _idResetController = TextEditingController();

  // 비밀번호 보기 여부를 관리할 변수
  bool _passwordVisible = false;

  // 비번 초기화 변수
  final TextEditingController _passwordResetController =
      TextEditingController();
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          TextField(
            keyboardType: TextInputType.text,
            onTapOutside: (event) => FocusManager.instance.primaryFocus
                ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
            controller: _idResetController, // 컨트롤러 연결
            decoration: InputDecoration(
              labelText: '아이디',
              labelStyle: const TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Color.fromARGB(255, 95, 95, 95),
                fontSize: 20,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 196, 208, 223),
                  width: 2,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _idResetController.clear(); // 텍스트 필드 내용 초기화
                },
                icon: const Icon(Icons.clear,
                    color: Color.fromARGB(255, 158, 158, 158)),
              ),
            ),
          ),
          const SizedBox(height: 50),
          TextField(
            keyboardType: TextInputType.text,
            onTapOutside: (event) => FocusManager.instance.primaryFocus
                ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
            controller: _passwordResetController, // 컨트롤러 연결
            obscureText: !_passwordVisible, // obscureText: true, // 비밀번호 가리기
            decoration: InputDecoration(
              labelText: '비밀번호',
              // helperText: '*필수 입력값입니다.',
              labelStyle: const TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Color.fromARGB(255, 95, 95, 95),
                fontSize: 20,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 196, 208, 223),
                  width: 2,
                ),
              ),
              // 오른쪽에 눈 아이콘 추가
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        // color: Theme.of(context).primaryColorDark,
                        color: _passwordVisible
                            ? const Color.fromARGB(255, 158, 158, 158)
                            : const Color.fromARGB(255, 158, 158, 158)),
                  ),
                  IconButton(
                    onPressed: () {
                      _passwordResetController.clear(); // 텍스트 필드 내용 초기화
                    },
                    icon: const Icon(Icons.clear,
                        color: Color.fromARGB(255, 158, 158, 158)),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          Column(
            children: [
              SizedBox(
                width: 372,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final dio = Dio();
                      final test = await dio
                          .post('http://10.0.2.2:4000/api/auth/login', data: {
                        'id': _idResetController.text,
                        'password': _passwordResetController.text,
                      });
                      final data = test.data['data'];
                      // SharedPreferences 인스턴스 생성
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('token', data['token']);
                      print('--------');
                      print(prefs.getString('token'));
                      // 로그인 버튼이 눌렸을 때 처리할 로직
                      context.go('/'); // 홈 화면으로 전환
                      //---> 아이디, 비밀번호가 맞으면 되도록 바꿔야 됨.
                    } catch (e) {
                      print('[로그인 버튼]');
                      // 여기서 넘어온 e는 타입을 알 수 없음.
                      // 그래서 연두색 타입으로 강제로 바꿔줌
                      DioException error = e as DioException;
                      // 에러 안에 응답 안에 응답코드로 구분해서
                      // 아이디 없음이나 비밀번호 틀림 등 에러 처리
                      // 물음표인 이유는 응답코드가 없을 수도 있어서
                      print(error.response?.statusCode);
                    }
                    print(_idResetController.text);
                    print(_passwordResetController.text);
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
                    '로그인',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    '아직 회원이 아니신가요?',
                    style: TextStyle(
                      fontFamily: "jeongianjeon-Regular",
                      fontSize: 14,
                      color: Color.fromARGB(255, 160, 160, 160),
                    ),
                  ),
                  const SizedBox(width: 10),
                  //GestureDetector(
                  InkWell(
                    highlightColor:
                        const Color.fromARGB(255, 236, 246, 250), // 꾸욱
                    splashColor: const Color.fromARGB(255, 236, 246, 250), // 타닥
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // '회원가입' 텍스트를 탭했을 때 처리할 로직
                      context.go('/join');
                    },
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        fontFamily: "jeongianjeon-Regular",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 134, 174, 190),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/');
                    },
                    child: const Text('로그아웃'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 59,
          ),
          /*  예시
          GestureDetector(
            onTap: () async {
              final test =
                  await dio.get('http://10.0.2.2:4000/api/board/free?page=1');
              print(test.data['data'][0]['no']);
            },
            child: const Text('버튼'),
          ),
          */
        ],
      ),
    );
  }
}
