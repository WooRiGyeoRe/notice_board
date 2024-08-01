import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_1/common/dio_service.dart';

// 자유게시판 글 작성
class FreeBoardWriteService {
  final Dio _dio = DioServices().getInstance();

  Future<Map<String, dynamic>> freeboarWrite(
      String title, String content) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('토큰이 없습니다.');
    }
    try {
      final response = await _dio.post(
        'http://10.0.2.2:4000/api/board/free',
        data: {
          "title": title,
          "content": content,
        },
        options: Options(
          headers: {
            'authorization': token,
          },
        ),
      );

      // 작성한 글 데이터를 로컬 스토리지에 저장
      List<String> posts = prefs.getStringList('posts') ?? [];
      posts.add(response.data.toString()); // 데이터 직렬화하여 저장
      await prefs.setStringList('posts', posts);

      return {
        'ok': true,
        'statusCode': response.statusCode,
        'message': '자유게시판 글 작성 성공',
        'data': response.data,
      };
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 400) {
          return {
            'ok': false,
            'statusCode': 400,
            'message': '제목, 내용 없음',
          };
        } else if (statusCode == 401) {
          return {
            'ok': false,
            'statusCode': 401,
            'message': '토큰 없은 또는 만료',
          };
        } else if (statusCode == 500) {
          return {
            'ok': false,
            'statusCode': 500,
            'message': '서버 오류',
          };
        }
      }
      throw Exception('자유게시판 글 작성 실패: $e');
    }
  }
}

// 자유게시판 글 불러오기
class FreeBoardListService {
  final Dio _dio = DioServices().getInstance();

  Future<Map<String, dynamic>> freeboardList(
    int no,
    // int boardCount, int allCounts
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('토큰이 없습니다.');
    }
    try {
      final response = await _dio.get(
        'http://10.0.2.2:4000/api/board/free?page=$no',
        options: Options(
          headers: {'authorization': token},
        ),
      );

      final data = response.data['data'];
      print('=============');
      print(response.data);
      print('=============');
      List<dynamic> posts = data['data'];
      List<Map<String, dynamic>> formattedPosts = posts.map((post) {
        return {
          'no': post['no'],
          'authorNo': post['author_no'],
          'title': post['title'],
          'content': post['content'],
          'createdAt': post['created_at'],
          'updatedAt': post['updated_at'],
          'author': post['author']['id'], // 'author' 필드 추가
          'nick': post['author']['nick'], // 'nick' 필드 추가
        };
      }).toList();

      return {
        'ok': true,
        'statusCode': response.statusCode,
        'message': '자유게시판 글 불러오기 성공',
        'data': response.data,
        'boardCount': data['boardCount'],
        'allCounts': data['allCounts'],
      };
    } catch (e) {
      if (e is DioException) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 400) {
          return {
            'ok': false,
            'statusCode': 400,
            'message': '페이지 번호 없음',
          };
        } else if (statusCode == 404) {
          return {
            'ok': false,
            'statusCode': 404,
            'message': '게시글 없음',
          };
        } else if (statusCode == 500) {
          return {
            'ok': false,
            'statusCode': 500,
            'message': '서버 오류',
          };
        }
      }
      throw Exception('자유게시판 글 불러오기 실패: ${e.toString()}');
    }
  }
}
