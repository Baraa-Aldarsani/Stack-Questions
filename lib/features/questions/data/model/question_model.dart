import '../../domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.id,
    required super.title,
    required super.body,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json['question_id'],
        title: json['title'],
        body: json['body'] ?? '',  
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'body': body,
      };

  factory QuestionModel.fromMap(Map<String, dynamic> map) => QuestionModel(
        id: map['id'],
        title: map['title'],
        body: map['body'],
      );
}
