class Question {
  final int id;
  final String title;
  final String body;

  Question({required this.id, required this.title, required this.body});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['question_id'],
      title: json['title'],
      body: json['body'] ?? '',
    );
  }
}
