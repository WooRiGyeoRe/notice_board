import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/provider/user_provider.dart';

// 회원가입
class JoinService {
  final Dio _dio = Dio();
  // JoinService(this._dio);

  // 로그인과 달리 회원가입 시 토큰 저장 X
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
      print(response.data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}

// final joinRepo = Provider((ref) {
//   return JoinService();
// });

final joinRepo = Provider((ref) => JoinService());

// 로그인
class LoginService {
  final Dio _dio = Dio(); // Dio 인스턴스 생성

  // 로그인 기능
  // Future -> 비동기 작업의 결과를 나타내는 객체로(미래에 완료될 수 있는 작업)
  Future<Map<String, dynamic>> login(String id, String password) async {
    try {
      // 로그인 요청 보내기
      // 로컬 저장소에 저장된 아이디와 비밀번호 확인
      final response =
          await _dio.post('http://10.0.2.2:4000/api/auth/login', data: {
        'id': id,
        'password': password,
      });

      final data =
          response.data['data']; // Dio 패키지를 통해 받은 HTTP 응답의 데이터(JSON 형식으로 반환)
      // SharedPreferences 인스턴스 생성
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']); // 토큰 저장
      await prefs.setString('id', data['id']);
      await prefs.setString('nick', data['nick']);

      // 로그인 성공
      print(response.data);
      print('-------로그인 서비스 응답 확인-------');
      // return response.data;

      return {
        'ok': true,
        'statusCode': 200,
        'message': '로그인 성공',
        'userData': response.data['data']
      };
    } catch (e) {
      rethrow;
    }
  }
}

final loginRepo = Provider((ref) => LoginService());

// 로그아웃
class LogoutService {
  final Dio _dio = Dio();

  Future<void> logout() async {
    try {
      // SharedPreferences 인스턴스를 생성
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('token'); // 토큰 가져오기
      print('로그아웃 서비스 쪽입니다');
      print(token);

      if (token == null) {
        print('로그아웃: 토큰 없음');
        return;
      }

      // 서버로 로그아웃 요청
      final response = await _dio.post(
        'http://10.0.2.2:4000/api/auth/logout',
        options: Options(
          headers: {
            'authorization': token,
          },
        ),
      );

      // 'token' 키에 저장된 값을 삭제.
      await prefs.remove('token');
      print('==== service');
      print(prefs.getString('token'));
      print('==== service');
      //  await prefs.clear();
      print('로그아웃 완료');
    } catch (e) {
      // 예외 발생 시 처리 로직을 추가할 수 있습니다.
      print(e);
      DioException error = e as DioException;
      print(error.response?.data);
      print('로그아웃 중 오류 발생');
    }
  }
}

// 회원탈퇴
class WithdrawalService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> withdrawal() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print(token);

      // 서버로 회원탈퇴 요청
      final response = await _dio.post(
        'http://10.0.2.2:4000/api/auth/local/withdraw',
        options: Options(
          headers: {'authorization': token},
        ),
      );

      // final data = response.data['data'];
      await prefs.clear(); // SharedPreferences에서 모든 데이터 삭제
      print('회원탈퇴 완료');
      return {
        'ok': true,
        'statusCode': 200,
        'message': '회원탈퇴 성공',
      };
    } catch (e) {
      print(e);
      print('회원탈퇴 중 오류 발생');
      rethrow;
    }
  }
}


/*
class BoardService {
  final Dio _dio = Dio();
  final String token;

  BoardService({
    required this.token,
  });

  Future<Map<String, dynamic>> getBoard() async {
    try {
      // 게시물가져오기
      final response = await _dio.get(
        'http://10.0.2.2:4000/api/board',
        options: Options(
          headers: {'authorization': token},
        ),
      );

      return response;
    } catch (e) {
      // 에러처리하고.

      //throw Exception;
    }
  }
}

final boardRepo = Provider((ref) {
  final token = ref.read(userAsyncProvider.notifier).getToken();

  if (token != null) {
    return BoardService(token: token);
  }

  return null;
});

*/