import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 회원가입
class JoinService {
  final Dio _dio = Dio();
  // JoinService(this._dio);

  // Future<Response> join(String id, String nick, String password)
  // 로그인고 달리 회원가입 시 토큰 저장 X
  Future<Map<String, dynamic>> join(
      String id, String nick, String password, String text) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:4000/api/auth/local/join',
        data: {
          'id': id,
          'nick': nick,
          'password': password,
        },
      );
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }
}

// 로그인
class LoginService {
  final Dio _dio = Dio(); // Dio 인스턴스 생성

  // 로그인 기능
  // Future -> 비동기 작업의 결과를 나타내는 객체로(미래에 완료될 수 있는 작업)
  Future<Map<String, dynamic>> login(String id, String password) async {
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
      // _showSuccessDialog();
      return {
        'ok': true,
      };
    } on DioException catch (e) {
      // if (e.response != null) {
      //   final int statusCode = e.response!.statusCode ?? 0;
      //   switch (statusCode) {
      //     case 400:
      //       rethrow;
      //     case 401:
      //       rethrow;
      //     case 403:
      //       rethrow;
      //     case 500:
      //       rethrow;
      //     default:
      //       return {
      //         'ok': false,
      //         'statusCode': '',
      //       };
      //   }
      // } else {
      //   return {
      //     'ok': false,
      //     'statusCode': '',
      //   };
      // }
      rethrow;
    } catch (e) {
      // 이 외 오류 예외처리
      rethrow;
    }
  }
}
