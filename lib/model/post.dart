class Post {
  late final String id;
  late final String title;
  late final String content;
  final String author;
  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'content': content,
    };
  }
}