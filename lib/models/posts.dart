class Comment {
  // ignore: non_constant_identifier_names
  final int user_id;
  final int id;
  final String title;
  final String body;

  Comment(
      // ignore: non_constant_identifier_names
      {required this.user_id,
      required this.id,
      required this.title,
      required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        user_id: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}
