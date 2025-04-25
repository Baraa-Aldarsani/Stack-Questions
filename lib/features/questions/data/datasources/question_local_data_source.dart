import 'package:sqflite/sqflite.dart';
import '../../domain/entities/question.dart';

abstract class QuestionLocalDataSource {
  Future<List<Question>> getCachedQuestions();
  Future<void> cacheQuestions(List<Question> questions);
}

class QuestionLocalDataSourceImpl implements QuestionLocalDataSource {
  final Database database;

  QuestionLocalDataSourceImpl(this.database);

  @override
  Future<List<Question>> getCachedQuestions() async {
    final List<Map<String, dynamic>> maps = await database.query('Questions');
    return maps.map((map) => Question.fromJson(map)).toList();
  }

  @override
  Future<void> cacheQuestions(List<Question> questions) async {
    final batch = database.batch();
    await database.delete('Questions');
    for (var question in questions) {
      batch.insert('Questions', question.toJson());
    }
    await batch.commit(noResult: true);
  }
}
