import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/service.dart';
import 'bottom_navi_bar.dart';
import 'home_screen.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage(String id, String passw, String s, {super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  var userName = TextEditingController(); // id 입력 저장
  var userPassword = TextEditingController(); // pw 입력 저장

  //flutter_secure_storage 사용을 위한 초기화 작업
  static const storage = FlutterSecureStorage();
  dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');

    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      context.go('/profile');
    } else {
      print('로그인을 해주세요.');
    }
  }

  // 로그인 버튼 누르면 실행
  loginAction(String id, String password) async {
    try {
      final loginService = LoginService();
      final result = await loginService.login(id, password);
      print('로그인 액션');
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('======profile');
    print('login');
    print('======');

    // AuthService 인스턴스 가져오기
    // final AuthService authService = Get.find();

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
  final dio = Dio();

  // 아이디 초기화 변수
  final TextEditingController _idController = TextEditingController();

  // 비밀번호 보기 여부를 관리할 변수
  bool _passwordVisible = false;

  // 비번 초기화 변수
  final TextEditingController _passwordController = TextEditingController();

  bool _idValid = true; // 유효 아이디 검증
  bool _passwordValid = true;
  bool _idInput = false;
  bool _passwordInput = false;

  void _validateId(String value) async {
    final prefs = await SharedPreferences.getInstance();

    final existingId = prefs.getString('id');
    setState(() {
      _idInput = value.isEmpty;
    });

    setState(() {
      _idValid = value.isNotEmpty;
    });
  }

  void _validatePassword(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final existingPassword = prefs.getString('password');
    setState(() {
      _passwordInput = value.isEmpty;
    });

    setState(() {
      _passwordValid = value.isNotEmpty;
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
            controller: _idController, // 컨트롤러 연결
            onChanged: _validateId,
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
              errorText: _idInput ? '아이디를 입력하세요.' : null,
              suffixIcon: IconButton(
                onPressed: () {
                  _idController.clear(); // 텍스트 필드 내용 초기화
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
            controller: _passwordController, // 컨트롤러 연결
            onChanged: _validatePassword,
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
              errorText: _passwordInput ? '비밀번호를 입력하세요' : null,
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
                      _passwordController.clear(); // 텍스트 필드 내용 초기화
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

                    // 여기 조건이 잘 못 된건지..  !_idValid || !_passwordValid
                    if (_idController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
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
                          .login(_idController.text, _passwordController.text);

                      print('-------------------------');
                      print(test); // 반환된 데이터 확인
                      print('-------------------------');

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                '로그인 성공!',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 111, 142, 179),
                                ),
                              ),
                              // 가입되어 있는 입력한 아이디가 출력되게ㅠㅠㅠㅠㅠㅠ
                              content: const Text(
                                  // '${test['id']}님 반갑습니다.\nTalk tok에서 즐겁게 활동을 시작해보세요 :)'),
                                  '반갑습니다.\nTalk tok에서 즐겁게 활동을 시작해보세요 :)'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // 로그인 버튼이 눌렸을 때 처리할 로직
                                    //---> 아이디, 비밀번호가 정상인 경우에만!
                                    context.go('/'); // 홈 화면으로 전환
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
                    print(_idController.text);
                    print(_passwordController.text);
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
        ],
      ),
    );
  }
}
