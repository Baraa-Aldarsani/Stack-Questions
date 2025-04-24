import 'package:sqflite/sqflite.dart';
import 'package:stack_questions_app/features/questions/data/model/question_model.dart';

abstract class QuestionLocalDataSource {
  Future<void> cacheQuestions(List<QuestionModel> questions);
  Future<List<QuestionModel>> getCachedQuestions();
}

class QuestionLocalDataSourceImpl implements QuestionLocalDataSource {
  final Database database;
  QuestionLocalDataSourceImpl(this.database);

  @override
  Future<void> cacheQuestions(List<QuestionModel> questions) async {
    final batch = database.batch();
    for (final question in questions) {
      batch.insert(
        'Questions',
        question.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<QuestionModel>> getCachedQuestions() async {
    final maps = await database.query('Questions');
    return maps.map((map) => QuestionModel.fromMap(map)).toList();
  }
}