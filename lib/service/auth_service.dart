/*
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 로그인&로그아웃
class AuthService {
  final Dio _dio = Dio(); // Dio 인스턴스 생성

  // 로그인 기능
  // Future -> 비동기 작업의 결과를 나타내는 객체로(미래에 완료될 수 있는 작업)
  Future<void> login(String id, String password) async {
    try {
      // 로그인 요청 보내기
      final response =
          await _dio.post('http://10.0.2.2:4000/api/auth/login', data: {
        'id': id,
        'password': password,
      });

      final data =
          response.data['data']; // Dio 패키지를 통해 받은 HTTP 응답의 데이터(JSON 형식으로 반환)

      // SharedPreferences 인스턴스 생성
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);

      // 로그인 성공 시, 홈 화면으로 이동
      _showSuccessDialog();
      Get.offAllNamed('/'); // GetX 패키지 -> 강력한 상태 관리와 라우팅 기능을 제공
    } on DioException catch (e) {
      if (e.response != null) {
        final int statusCode = e.response!.statusCode ?? 0;
        switch (statusCode) {
          case 400:
            _showErrorDialog('아이디 혹은 비밀번호를 입력하세요.');
            break;
          case 401:
            _showErrorDialog('비밀번호가 올바르지 않습니다.');
            break;
          case 403:
            _showErrorDialog('아이디를 찾을 수 없습니다.');
            break;
          case 500:
            _showErrorDialog('서버 오류가 발생했습니다.');
            break;
          default:
            _showErrorDialog('오류가 발생했습니다.');
            break;
        }
      } else {
        _showErrorDialog('서버에서 응답이 없습니다.');
      }
    } catch (e) {
      // 이 외 오류 예외처리
      _showErrorDialog('로그인 중 오류가 발생했습니다.');
    }
  }

  // 로그인 성공
  void _showSuccessDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그인 성공'),
          content: const Text('로그인 성공! 환영합니다 :)'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 로그인 실패
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('로그인 실패'),
          content: const Text('로그인 실패!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

/*  catch (e) {
      // 로그인 실패 시
      // $ 기호 -> 문자열 내에서 변수나 표현식의 값을 삽입하는 문자열 보간(interpolation) 문법
      print('로그인 실패! $e');
      throw Exception('로그인 실패');
    } */

// 로그아웃 기능
Future<void> logout() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // 토근 삭제

    // 로그아웃 후, 홈 화면으로 이동
    Get.offAllNamed('/');
  } catch (e) {
    print('로그아웃 실패! $e');
    throw Exception('로그아웃 실패');
  }
}

*/