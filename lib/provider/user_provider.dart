import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAsyncNotifier extends AutoDisposeAsyncNotifier<String?> {
  late final SharedPreferences _prefs;
  String? _data = '';

  @override
  FutureOr<String?> build() async {
    _prefs = await SharedPreferences.getInstance();
    return getToken();
  }

  String? getToken() {
    try {
      final token = _prefs.getString('token');
      state = AsyncValue.data(token);
      _data = token;
      return _data;
    } catch (e) {
      //
      return null;
    }
  }
}

// <클래스 타입 가져오기, 반환값>
final userAsyncProvider =
    AutoDisposeAsyncNotifierProvider<UserAsyncNotifier, String?>(
  () {
    return UserAsyncNotifier();
  },
);
