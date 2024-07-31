import 'package:dio/dio.dart';
// import 'package:lalalabs_flutter/common/services/dio_interceptor.dart';

class DioServices {
  static final DioServices _dioServices = DioServices._internal();
  factory DioServices() => _dioServices;
  Map<String, dynamic> dioInformation = {};

  static Dio _dio = Dio();

  DioServices._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: 'http://10.0.2.2:4000/api/',
      connectTimeout: const Duration(milliseconds: 60000),
      receiveTimeout: const Duration(milliseconds: 60000),
      sendTimeout: const Duration(milliseconds: 60000),
    );
    _dio = Dio(options);
  }

  Dio getInstance() {
    return _dio;
  }
}
