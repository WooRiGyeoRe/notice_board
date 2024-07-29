import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Map 타입에다가 token, nick, id 담기.
class UserAsyncNotifier extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late final SharedPreferences _prefs;
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
}

// <클래스 타입 가져오기, 반환값>
final userAsyncProvider =
    AutoDisposeAsyncNotifierProvider<UserAsyncNotifier, Map<String, dynamic>>(
  () {
    return UserAsyncNotifier();
  },
);
