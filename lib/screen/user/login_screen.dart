// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/provider/user_provider.dart';
import 'package:test_1/screen/bottom_navi_bar.dart';
import 'package:test_1/screen/user/profile_screen.dart';
import 'package:test_1/service/user_service.dart';

class MyLoginPage extends ConsumerStatefulWidget {
  const MyLoginPage({super.key});

  @override
  ConsumerState<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends ConsumerState<MyLoginPage> {
  // 로그인 버튼 누르면 실행
  loginAction(String id, String password, String nick) async {
    try {
      print('로그인 액션');
      final loginService = LoginService();
      await loginService.login(id, password);

      // 로그인 후 프로필 화면으로 이동
      // 상태를 업데이트하여 프로필 화면으로 이동
      context.go('/profile');
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // return const LoginScreen();
    return const ProfileScreen();
  }
}

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // initState에서 로그인 상태 확인
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      // 이미 로그인된 상태라면 프로필 화면으로 바로 이동
      context.go('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('======profile');
    print('login');
    print('======');

    // Scaffold 레이아웃 위젯 중 하나로, 앱의 기본 구조를 정의
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: ref.watch(userAsyncProvider).when(
            data: (data) {
              print(data);
              if (data['token'] == null) {
                // 로그인 X
                return const Column(
                  children: [
                    LoginForm(),
                  ],
                );
              } else {
                // 로그인되어 있으면 프로필 화면으로 이동
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go('/profile');
                });
                return Container();

                /*
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.goNamed('profile');
                      },
                      child: const Text('나'),
                    ),
                  ],
                );
                */
              }
            },
            error: (error, stackTrace) {
              return Container();
            },
            loading: () => const CircularProgressIndicator(),
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
  final dio = Dio();

  // 아이디 초기화 변수
  final TextEditingController idController = TextEditingController();

  // 비밀번호 보기 여부를 관리할 변수
  bool passwordVisible = false;

  // 비번 초기화 변수
  final TextEditingController passwordController = TextEditingController();

  bool idValid = true; // 유효 아이디 검증
  bool passwordValid = true;
  bool idInput = false;
  bool passwordInput = false;

  void validateId(String value) async {
    final prefs = await SharedPreferences.getInstance();

    final existingId = prefs.getString('id');
    setState(() {
      idInput = value.isEmpty;
    });

    setState(() {
      idValid = value.isNotEmpty;
    });
  }

  void validatePassword(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final existingPassword = prefs.getString('password');
    setState(() {
      passwordInput = value.isEmpty;
    });

    setState(() {
      passwordValid = value.isNotEmpty;
    });
  }

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
            controller: idController, // 컨트롤러 연결
            onChanged: validateId,
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
              errorText: idInput ? '아이디를 입력하세요.' : null,
              suffixIcon: IconButton(
                onPressed: () {
                  idController.clear(); // 텍스트 필드 내용 초기화
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
            controller: passwordController, // 컨트롤러 연결
            onChanged: validatePassword,
            obscureText: !passwordVisible, // obscureText: true, // 비밀번호 가리기
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
              errorText: passwordInput ? '비밀번호를 입력하세요' : null,
              // 오른쪽에 눈 아이콘 추가
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        // color: Theme.of(context).primaryColorDark,
                        color: passwordVisible
                            ? const Color.fromARGB(255, 158, 158, 158)
                            : const Color.fromARGB(255, 158, 158, 158)),
                  ),
                  IconButton(
                    onPressed: () {
                      passwordController.clear(); // 텍스트 필드 내용 초기화
                    },
                    icon: const Icon(Icons.clear,
                        color: Color.fromARGB(255, 158, 158, 158)),
                  ),
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
                    // 로컬저장소에 저장된 아이디, 비밀번호
                    final prefs = await SharedPreferences.getInstance();
                    final existingId = prefs.getString('id');
                    final existingPassword = prefs.getString('password');

                    // 조건... !_idValid || !_passwordValid
                    if (idController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              '필수 입력란이 비었습니다. \n확인해주세요.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 111, 142, 179),
                              ),
                            ),
                            content: const Text('아이디, 비밀번호를 모두 입력해주세요.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  '확인',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 111, 142, 179),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    try {
                      final test = await LoginService()
                          .login(idController.text, passwordController.text);

                      // print('-------------------반환된 데이터 확인');
                      // print(test['userData']['token']); // 반환된 데이터 확인
                      // print('-------------------------');

                      // // 로그인 성공하면 토큰을 저장
                      // await prefs.setString('token', test['userData']['token']);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            final nick = prefs.getString('nick');
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                '로그인 성공!',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 111, 142, 179),
                                ),
                              ),
                              // ${data.name}
                              // ${data.name}ABC // 뒤에 올 게 영어일 경우
                              // 가입되어 있는 입력한 아이디가 출력되게ㅠㅠㅠㅠㅠㅠ
                              content: Text(
                                  '$nick님 반갑습니다.\nTalk tok에서 즐겁게 활동을 시작해보세요 :)'),
                              // '반갑습니다.\nTalk tok에서 즐겁게 활동을 시작해보세요 :)'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    print('잘 받아오느냐!!?');
                                    Navigator.of(context).pop();
                                    // 확인 버튼 눌렸을 때 처리할 로직
                                    //---> 아이디, 비밀번호가 정상인 경우에만!
                                    if (idValid && passwordValid) {
                                      context.go('/profile'); // 홈 화면으로 전환
                                    }
                                  },
                                  child: const Text(
                                    '확인',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 111, 142, 179),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                      // // SharedPreferences 인스턴스 생성
                      /* final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('token', data['token']); 
                      print(prefs.getString('token'));
                      */
                    } catch (e) {
                      print('[로그인 버튼]');
                      if (e is DioException) {
                        /*
                          if (e.response?.statusCode == 400) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: const Text(
                                    '필수 입력란이 비었습니다. \n확인해주세요.',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 111, 142, 179),
                                    ),
                                  ),
                                  content: const Text('아이디, 비밀번호를 모두 입력해주세요.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        '확인',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 111, 142, 179),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } 
                          */
                        if (e.response?.statusCode == 401) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white, // 다이얼로그 배경색
                                title: const Text(
                                  '비밀번호 오류',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 111, 142, 179),
                                  ),
                                ),
                                content: const Text('비밀번호가 틀렸습니다. 다시 입력해주세요.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // 다이얼로그 닫기
                                    },
                                    child: const Text(
                                      '확인',
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 111, 142, 179), // 버튼 텍스트 색상
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (e.response?.statusCode == 404) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white, // 다이얼로그 배경색
                                title: const Text(
                                  '아이디 오류',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 111, 142, 179),
                                  ),
                                ),
                                content: const Text('없는 아이디입니다. 다시 입력해주세요.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // 다이얼로그 닫기
                                    },
                                    child: const Text(
                                      '확인',
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 111, 142, 179), // 버튼 텍스트 색상
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (e.response?.statusCode == 500) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white, // 다이얼로그 배경색
                                title: const Text(
                                  '서버 오류가 발생했습니다.',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 111, 142, 179),
                                  ),
                                ),
                                content: const Text('다시 로그인해주세요.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // 다이얼로그 닫기
                                    },
                                    child: const Text(
                                      '확인',
                                      style: TextStyle(
                                        color: Color.fromARGB(
                                            255, 111, 142, 179), // 버튼 텍스트 색상
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    }
                    print(idController.text);
                    print(passwordController.text);
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
          const SizedBox(
            height: 59,
          ),
        ],
      ),
    );
  }
}
