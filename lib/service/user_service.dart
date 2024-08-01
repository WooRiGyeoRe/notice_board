import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/common/dio_service.dart';
import 'package:test_1/model/user.dart';
import 'package:test_1/provider/user_provider.dart';

// 회원가입
final joinRepo = Provider((ref) => JoinService());

class JoinService {
  // final Dio _dio = Dio();
  // JoinService(this._dio);
  final Dio _dio = DioServices().getInstance();

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

// 로그인
final loginRepo = Provider((ref) => LoginService());

class LoginService {
  // final Dio _dio = Dio(); // Dio 인스턴스 생성
  final Dio _dio = DioServices().getInstance();

  // 로그인 기능
  // Future -> 비동기 작업의 결과를 나타내는 객체로(미래에 완료될 수 있는 작업)
  Future<Map<String, dynamic>> login(String id, String password) async {
    try {
      // 로그인 요청 보내기
      // 로컬 저장소에 저장된 아이디와 비밀번호 확인
      final response = await _dio.post(
        'http://10.0.2.2:4000/api/auth/login',
        data: {
          'id': id,
          'password': password,
        },
      );

      final data =
          response.data['data']; // Dio 패키지를 통해 받은 HTTP 응답의 데이터(JSON 형식으로 반환)
      print('=============');
      print(response.data);
      print('=============');
      final test2 = UserModel.fromJson(response.data);
      print(test2);
      // test2.data.no;
      // SharedPreferences 인스턴스 생성
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']); // 토큰 저장 // tst2.data.token
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
      print(e);
      rethrow;
    }
  }
}

// 로그아웃
class LogoutService {
  // final Dio _dio = Dio();
  final Dio _dio = DioServices().getInstance();

  Future<void> logout() async {
    try {
      // SharedPreferences 인스턴스를 생성
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.clear();
      final token = prefs.getString('token'); // 토큰 가져오기
      print('로그아웃 서비스 쪽입니다');
      print(token);

      if (token == null) {
        print('로그아웃: 토큰 없음');
        return;
      }
      try {
        final response = await _dio.post(
          'http://10.0.2.2:4000/api/auth/logout',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      } catch (e) {
        if (e is DioException && e.response?.statusCode == 401) {
          print('토큰 만료, 로그아웃 처리');
        } else {
          rethrow;
        }
      }

      await prefs.remove('token');
      print('==== service');
      print(prefs.getString('token'));
      print('==== service');
      print('로그아웃 완료');
    } catch (e) {
      print('로그아웃 중 오류 발생: $e');
    }
  }
}

// 회원탈퇴
class WithdrawalService {
  // inal Dio _dio = Dio();
  final Dio _dio = DioServices().getInstance();

  Future<Map<String, dynamic>> withdrawal() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print(token);

      if (token == null) {
        print('회원탈퇴: 토큰 없음');
        return {
          'ok': false,
          'statusCode': 401,
          'message': '토큰 없음',
        };
      }
      try {
        // 서버로 회원탈퇴 요청
        final response = await _dio.post(
          'http://10.0.2.2:4000/api/auth/local/withdraw',
          options: Options(
            headers: {'authorization': token},
          ),
        );
        print('서버 응답: ${response.data}');
      } catch (e) {
        if (e is DioException && e.response?.statusCode == 401) {
          print('토큰 만료, 회원탈퇴 실패');

          await prefs.clear(); // SharedPreferences에서 모든 데이터 삭제
          return {
            'ok': false,
            'statusCode': 401,
            'message': '토큰 없음 혹은 만료',
          };
        } else {
          rethrow;
        }
      }

      await prefs.clear(); // SharedPreferences에서 모든 데이터 삭제
      return {
        'ok': true,
        'statusCode': 200,
        'message': '회원탈퇴 성공',
      };
    } catch (e) {
      print('회원탈퇴 중 오류 발생: $e');
      rethrow;
    }
  }
}

// 닉네임 수정
class UpdateNickService {
  // final Dio _dio;
  // UpdateNickService(this._dio);
  final Dio _dio = DioServices().getInstance();

  UpdateNickService(Dio dio);

  Future<Map<String, dynamic>> updateNick(String newNick) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('토큰이 없습니다.');
    }

    try {
      final response = await _dio.patch(
        'http://10.0.2.2:4000/api/users',
        data: {
          'nick': newNick,
        },
        options: Options(
          headers: {
            'authorization': token,
          },
        ),
      );

      return {
        'ok': true,
        'statusCode': response.statusCode,
        'message': '닉네임 수정 성공',
        'data': response.data,
      };
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return {
            'ok': false,
            'statusCode': 401,
            'message': '토큰 만료',
          };
        } else if (statusCode == 409) {
          return {
            'ok': false,
            'statusCode': 409,
            'message': '닉네임이 이미 사용 중입니다.',
          };
        } else if (statusCode == 500) {
          return {
            'ok': false,
            'statusCode': 500,
            'message': '서버 오류',
          };
        }
      }
      throw Exception('닉네임 업데이트 실패: $e');
    }
  }
}
