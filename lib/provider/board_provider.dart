// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authProvider = StateProvider<bool>((ref) => false);
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_1/model/Board.dart';

/*
class BoardViewModel extends AsyncNotifier<Board> {
  late final BoardService _repo;
  late Board data;

  @override
  FutureOr<Board> build() async{
    _repo = ref.read(boardRepo);
    data = await fetchData(1);
  }

  FutureOr<Board> _fetchData(int pageNo) async {
    final result = await _repo.getBoard(pageNo);
    Board tmp = Board(no: result['no'], authorId: result['author_no']);
    return tmp;
  }

   FutureOr<Board> fetchData(int pageNo) async {
    return _fetchData(pageNo);
  }
}


final boardProvider = AsyncNotifierProvider<BoardViewModel, Board>(()=> BoardViewModel(),);


///  BoardScreen 

ref.watch(boardProvider)


ref.read(boardProvider.notifier).fetchData(2);

*/

 