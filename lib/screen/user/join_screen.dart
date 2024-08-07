import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/service/user_service.dart';

import 'package:go_router/go_router.dart';

class JoinScreen extends StatelessWidget {
  const JoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('======profile');
    print('join');
    print('======');
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
  // SharedPreferences 변수 선언
  late SharedPreferences prefs;

  // 아이디 초기화 변수
  final TextEditingController _idController = TextEditingController();

  // 닉네임 초기화 변수
  final TextEditingController _nickController = TextEditingController();

  // 비밀번호 초기화 변수 (비번1)
  final TextEditingController _passwordController = TextEditingController();

  // 비밀번호 확인란 초기화 변수 (비번2)
  final TextEditingController _passwordCheckController =
      TextEditingController();

  // 비밀번호 보기 여부를 관리할 변수 (비번1)
  bool _passwordVisible = false;

  // 비밀번호 확인란 보기 여부를 관리할 변수 (비번2)
  bool _passwordCheckVisible = false;

  bool _idValid = true; // 유효 아이디 검증 // 초기 에러 메세지 숨김
  bool _idInput = false; // 아이디 입력 여부
  bool _nickValid = true;
  bool _nickInput = false;
  bool _passwordValid = true;
  bool _passwordInput = false;
  bool _password2Input = false;
  bool _password2Valid = true;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  // SharedPreferences 초기화 메서드
  void _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _validateId(String value) async {
    // SharedPreferences가 로드되기 전에는 처리하지 않음
    final prefs = await SharedPreferences.getInstance();
    // existingId = 현존하는 아이디
    final existingId = prefs.getString('id'); // 로컬 스토리지에서 기존 아이디 가져오기

    setState(() {
      _idInput = true; // 사용자가 입력을 시작하면 true로 설정
      // 아이디 영어 소문자 5글자 이상
      _idValid = RegExp(r'^[a-z0-9]{5,}$').hasMatch(value);

      // 기존 아이디와 동일한 경우 검증 실패
      // 널이 아니다 = 현존한다 && 현존 아이디 == 입력값이다 -> 둘다 참이면 입력한 아이디는 false = 회원가입 불가
      if (existingId != null && existingId == value) {
        _idValid = false;
      }
    });
  }

  void _validateNick(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final existingNick = prefs.getString('nick');

    setState(() {
      _nickInput = true; // 사용자가 입력을 시작하면 true로 설정
      // 닉네임 한글, 영어 소문자 한글자 이상
      _nickValid = RegExp(r'^[a-z가-힣0-9]{1,}$').hasMatch(value);

      // 기존 닉네임과 동일한 경우 검증 실패
      // 널이 아니다 = 현존한다 && 현존 아이디 == 입력값이다 -> 둘다 참이면 입력한 닉네임은 false
      if (existingNick != null && existingNick == value) {
        _nickValid = false;
      }
    });
  }

  // 비밀번호 유효성 검사 함수
  void _validatePassword(String value) {
    setState(() {
      _passwordInput = true; // 비밀번호 입력 여부 true로 설정
      // 정규식을 사용한 비밀번호 유효성 검사:  특수문자 최소 1개 + 영문자, 숫자 조합으로 5글자 이상
      _passwordValid =
          RegExp(r'^(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,}$').hasMatch(value);
    });
  }

  // 비밀번호 확인 유효성 검사
  void _validate2Password(String value) {
    setState(() {
      _password2Input = true;
      // _password2Valid = value.isNotEmpty;
      // _password2Valid = _passwordController.text == value;
      _password2Valid = _passwordController.text == value || value.isEmpty;
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
            controller: _idController,
            onChanged: _validateId, // 아이디 입력값이 변경될 때마다 검증 함수 호출
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
                  _idController.clear(); // 텍스트 필드 내용 초기화
                  _validateId(''); // 초기화 후 검증 상태 업데이트
                  setState(() {
                    _idInput = false; // 텍스트 필드 초기화 시 다시 false로 설정
                  });
                },
                icon: const Icon(Icons.clear,
                    color: Color.fromARGB(255, 158, 158, 158)),
              ),
              // 검증 실패 시 에러 메시지, 사용자가 입력을 시작한 후에만 표시
              errorText: _idInput && !_idValid
                  ? '영어 소문자, 숫자를 조합하여 5글자 이상 입력해주세요.'
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.text,
            onTapOutside: (event) => FocusManager.instance.primaryFocus
                ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
            controller: _nickController,
            onChanged: _validateNick,
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
                  _nickController.clear(); // 텍스트 필드 내용 초기화
                  _validateNick('');
                  setState(() {
                    _nickInput = false;
                  });
                },
                icon: const Icon(Icons.clear,
                    color: Color.fromARGB(255, 158, 158, 158)),
              ),
              errorText: _nickInput && !_nickValid ? '한 글자 이상 입력해주세요.' : null,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.text,
            onTapOutside: (event) => FocusManager.instance.primaryFocus
                ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
            controller: _passwordController,
            onChanged: _validatePassword,
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
                      _passwordController.clear(); // 텍스트 필드 내용 초기화
                      _validatePassword('');
                      setState(() {
                        _passwordInput = false;
                      });
                    },
                    icon: const Icon(Icons.clear,
                        color: Color.fromARGB(255, 158, 158, 158)),
                  ),
                ],
              ),
              errorText: _passwordInput && !_passwordValid
                  ? '특수문자 1개 이상, 영문자, 숫자를 조합하여 5글자 이상 입력하세요.'
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            onTapOutside: (event) => FocusManager.instance.primaryFocus
                ?.unfocus(), // 키보드 외 구역 터치 시, 사라짐
            keyboardType: TextInputType.text,
            controller: _passwordCheckController,
            obscureText: !_passwordCheckVisible,
            onChanged: _validate2Password,
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
                      _validate2Password('');
                      setState(() {
                        _password2Input = true;
                      });
                    },
                    icon: const Icon(Icons.clear,
                        color: Color.fromARGB(255, 158, 158, 158)),
                  ),
                ],
              ),
              errorText: _password2Input && !_password2Valid
                  ? '비밀번호를 다시 확인해주세요.'
                  : null,
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
                    // 로컬저장소에 저장된 아이디, 닉네임
                    final prefs = await SharedPreferences.getInstance();
                    final existingId = prefs.getString('id');
                    final existingNick = prefs.getString('nick');

                    if (_idController.text.isEmpty ||
                        _nickController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _passwordCheckController.text.isEmpty) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white, // 다이얼로그 배경색
                            title: const Text(
                              '필수 입력란이 비었습니다. \n확인해주세요.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 111, 142, 179),
                              ),
                            ),
                            content: const Text('아이디, 닉네임, 비밀번호를 모두 입력해주세요.'),
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
                      return; // 필드가 유효하지 않거나 비어있으면 다이얼로그를 표시하지 않고 반환
                    }

                    print(_idValid);

                    // 모든 필드가 유효하고 채워져 있으면 회원가입 진행
                    if (!_passwordValid ||
                        !_password2Valid ||
                        !_idValid ||
                        !_nickValid) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              '회원가입 오류',
                              style: TextStyle(
                                color: Color.fromARGB(255, 111, 142, 179),
                              ),
                            ),
                            content: const Text('회원가입 양식을 정확히 입력해주세요.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
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
                      return;
                    }
                    try {
                      print('이야아아아아압!!!');
                      final test = await JoinService().join(
                          _idController.text,
                          _nickController.text,
                          _passwordController.text,
                          _passwordCheckController.text);
                      print('-------------------------');
                      print(test);
                      print('-------------------------');

                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: const Text(
                              '회원가입이 완료되었습니다.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 111, 142, 179),
                              ),
                            ),
                            content: const Text('Talk tok의 회원이 되신 것을 환영합니다♥'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context.go(
                                      '/login'); // 확인 누르면 화면전환 (재로그인 vs 바로 로그인?)
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
                    } catch (e) {
                      print(e);
                      if (e is DioException) {
                        // DioErrorType에 따른 예외 처리
                        if (e.response?.statusCode == 409) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white, // 다이얼로그 배경색
                                title: const Text(
                                  '이미 사용 중인 아이디 \n혹은 닉네임입니다.',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 111, 142, 179),
                                  ),
                                ),
                                content: const Text('아이디 혹은 닉네임을 다시 입력해주세요.'),
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
                          // ignore: use_build_context_synchronously
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
                                content: const Text('회원가입을 다시 진행해주세요.'),
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
                    print(_nickController.text);
                    print(_passwordController.text);
                    print(_passwordCheckController.text);
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
                      // 로그인 텍스트 탭했을 때
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
