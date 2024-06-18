import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'bottom_navi_bar.dart';
import 'package:go_router/go_router.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 오버플로우 해결
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '회원가입',
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
        backgroundColor: const Color.fromARGB(255, 185, 215, 224), // 앱바 배경색
        elevation: 3, // 그림자 깊이
        shadowColor: Colors.black, // 앱바 그림자
      ),
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
  // 아이디 초기화 변수
  final TextEditingController _idResetController = TextEditingController();

  // 닉네임 초기화 변수
  final TextEditingController _nickResetController = TextEditingController();

  // 비밀번호 초기화 변수 (비번1)
  final TextEditingController _passwordResetController =
      TextEditingController();

  // 비밀번호 확인란 초기화 변수 (비번2)
  final TextEditingController _passwordCheckController =
      TextEditingController();

  // 비밀번호 보기 여부를 관리할 변수 (비번1)
  bool _passwordVisible = false;

  // 비밀번호 확인란 보기 여부를 관리할 변수 (비번2)
  bool _passwordCheckVisible = false;

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
            controller: _idResetController,
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
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.text,
            controller: _nickResetController,
            decoration: InputDecoration(
              labelText: '닉네임',
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
                  _nickResetController.clear(); // 텍스트 필드 내용 초기화
                },
                icon: const Icon(Icons.clear,
                    color: Color.fromARGB(255, 158, 158, 158)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.text,
            controller: _passwordResetController,
            obscureText: !_passwordVisible,
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
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.text,
            controller: _passwordCheckController,
            obscureText: !_passwordCheckVisible,
            decoration: InputDecoration(
              labelText: '비밀번호 확인',
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
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _passwordCheckVisible = !_passwordCheckVisible;
                      });
                    },
                    icon: Icon(
                        _passwordCheckVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        // color: Theme.of(context).primaryColorDark,
                        color: _passwordCheckVisible
                            ? const Color.fromARGB(255, 158, 158, 158)
                            : const Color.fromARGB(255, 158, 158, 158)),
                  ),
                  IconButton(
                    onPressed: () {
                      _passwordCheckController.clear(); // 텍스트 필드 내용 초기화
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
                    context.go('/login');
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
                  //GestureDetector(
                  InkWell(
                    highlightColor:
                        const Color.fromARGB(255, 236, 246, 250), // 꾸욱
                    splashColor: const Color.fromARGB(255, 236, 246, 250), // 타닥
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // '로그인' 텍스트를 탭했을 때 처리할 로직
                      context.go('/login');
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
        ],
      ),
    );
  }
}
