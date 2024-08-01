class Post {
  final int no;
  final String authorNo;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String author;
  final String nick;

  Post({
    required this.no,
    required this.authorNo,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
    required this.nick,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      no: json['no'],
      authorNo: json['authorNo'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      author: json['author'],
      nick: json['nick'],
    );
  }
}
