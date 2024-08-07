import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:test_1/provider/user_provider.dart';
import 'package:test_1/screen/board/board_content_screen.dart';
import 'package:test_1/screen/board/board_screen.dart';
import 'package:test_1/screen/board/write_change_screen.dart';
import 'package:test_1/screen/board/write_screen.dart';
import 'package:test_1/screen/comment/comment_change_screen.dart';
import 'package:test_1/screen/user/join_screen.dart';
import 'package:test_1/screen/user/login_screen.dart';
import 'package:test_1/screen/user/profile_screen.dart';
import 'screen/comment/comment_screen.dart';
import 'screen/home_screen.dart';
import 'screen/bottom_navi_bar.dart';

// 고라우터 기본 구조
/*
final routerProvider = Provider((ref) {
  return GoRouter(routes: []);
});
*/

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: '/', // 초기 경로 설정
      routes: [
        // 홈 화면(메인페이지)
        GoRoute(
          name: 'home', // (선택사항) 라우트에 이름 추가 -> 이름으로 경로 이동이 가능해짐
          path: '/', // 경로 URL
          builder: (context, state) => HomeScreen(
              key: state
                  .pageKey), // builder 함수는 BuildContext와 GoRouterState를 받아서 위젯을 반환해야 함!
        ),
        // 프로필 탭 -> 로그인 페이지
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => LoginScreen(key: state.pageKey),
          // redirect
        ),
        // 프로필 탭 -> 로그인 -> 내 프로필
        GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, state) => ProfileScreen(key: state.pageKey),
        ),
        // 게시판(free, q&a)
        GoRoute(
          name: 'board',
          path: '/board',
          builder: (context, state) => BoardScreen(
            key: state.pageKey,
            // extra: state.extra ??
            //     'default', // state.extra가 null일 경우 'default' 값으로 설정
            // extra: state.extra!,
            extra: state.extra ?? 'default',
          ),
        ),
        // 게시물
        GoRoute(
          name: 'boardcontent',
          path: '/boardcontent',
          builder: (context, state) => BoardContentScreen(
            key: state.pageKey,
            // extra: state.extra ??
            //     'default', // state.extra가 null일 경우 'default' 값으로 설정
            // extra: state.extra!,
            extra: state.extra ?? 'default',
          ),
        ),

        // 자유게시판
        /*  GoRoute(
            name: 'free',
           path: '/free',
              builder: (context, state) => BoardScreen(
              key: state.pageKey,
             extra: 'free', // 자유게시판
            ),
        ), */
        // // 질문게시판
        /*  GoRoute(
           name: 'q&a',
            path: '/q&a',
            builder: (context, state) => BoardScreen(
            key: state.pageKey,
            extra: 'q&a', // 질문게시판
            ),
         ), */

        // 회원가입 페이지
        GoRoute(
          name: 'join',
          path: '/join',
          builder: (context, state) => JoinScreen(key: state.pageKey),
        ),
        // 글 작성 페이지(free write, q&a write)
        GoRoute(
          name: 'write',
          path: '/write',
          builder: (context, state) => WriteScreen(
            key: state.pageKey,
            extra: state.extra!,
          ),
        ),
        // 글 수정 페이지
        GoRoute(
          name: 'writechange',
          path: '/writechange',
          builder: (context, state) {
            // state.extra를 사용해 WriteChangeScreen에 전달할 데이터를 결정합니다.
            final extra = state.extra as String? ?? '';
            return WriteChangeScreen(
              key: state.pageKey,
              extra: extra,
            );
          },
        ),
        // 댓글 작성 페이지(free comment, q&a comment)
        GoRoute(
          name: 'comment',
          path: '/comment',
          builder: (context, state) => CommentScreen(key: state.pageKey),
        ),
        // 댓글 수정
        GoRoute(
          name: 'commentedit',
          path: '/commentedit',
          builder: (context, state) {
            final extra = state.extra as String? ?? '';
            return CommentChangeScreen(
              key: state.pageKey,
              extra: extra,
            );
          },
        ),
      ],
    );
  },
);
