// 회원가입 기능
import 'package:dio/dio.dart';

class JoinService {
  final Dio _dio;

  JoinService(this._dio);

  Future<Response> join(String id, String nick, String password) async {
    try {
      final response = await _dio.post(
        'http://10.0.2.2:4000/api/auth/local/join',
        data: {
          'id': id,
          'nick': nick,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
