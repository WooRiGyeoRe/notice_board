import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Map 타입에다가 token, nick, id 담기.
class UserAsyncNotifier extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late final SharedPreferences _prefs;
  late final Dio _dio; // 추가
  Map<String, dynamic> _data = {};

  @override
  FutureOr<Map<String, dynamic>> build() async {
    _prefs = await SharedPreferences.getInstance();
    return getToken();
  }

  Map<String, dynamic> getToken() {
    try {
      final userData = {
        'token': _prefs.getString('token'),
        'id': _prefs.getString('id'),
        'nick': _prefs.getString('nick')
      };
      state = AsyncValue.data(userData);
      _data = userData;
      return _data;
    } catch (e) {
      // rethrow;
      return {};
    }
  }

  // 닉네임을 업데이트하는 메서드
  Future<void> updateNick(String newNick) async {
    try {
      // SharedPreferences에 새로운 닉네임 저장
      await _prefs.setString('nick', newNick);

      // 업데이트된 데이터를 state에 반영
      _data['nick'] = newNick;
      state = AsyncValue.data(_data);
    } catch (e) {
      rethrow;
    }
  }
}

// <클래스 타입 가져오기, 반환값>
final userAsyncProvider =
    AutoDisposeAsyncNotifierProvider<UserAsyncNotifier, Map<String, dynamic>>(
  () {
    return UserAsyncNotifier();
  },
);
