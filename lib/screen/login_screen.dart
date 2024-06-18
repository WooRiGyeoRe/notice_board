import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'bottom_navi_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold 레이아웃 위젯 중 하나로, 앱의 기본 구조를 정의
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬 설정
          crossAxisAlignment: CrossAxisAlignment.center, // 세로 정렬 설정 추가
          children: [
            Text(
              '로그인',
              style: TextStyle(
                fontFamily: "jeongianjeon-Regular",
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 185, 215, 224),
        elevation: 3,
        // 뒤로 가기 버튼
        /*
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        */
        shadowColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: const Column(
        children: [LoginForm()],
      ),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 50),
          TextField(
            keyboardType: TextInputType.text,
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
            controller: _passwordResetController, // 컨트롤러 연결
            obscureText: !_passwordVisible, // obscureText: true, // 비밀번호 가리기
            decoration: InputDecoration(
              labelText: '비밀번호',
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
                  onPressed: () {
                    // 로그인 버튼이 눌렸을 때 처리할 로직
                    // context.go('/'); // 홈 화면으로 전환 ---> 아이디, 비밀번호가 맞으면 되도록 바꿔야 됨.
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
