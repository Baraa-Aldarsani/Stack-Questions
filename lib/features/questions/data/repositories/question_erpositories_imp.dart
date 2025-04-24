import 'package:stack_questions_app/core/network/network_info.dart';

import '../../domain/entities/question.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/question_local_data_source.dart';
import '../datasources/question_remote_data_source.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource remoteDataSource;
  final QuestionLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  QuestionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Question>> getQuestions({int page = 1}) async {
    if (await networkInfo.isConnected) {
      final remoteQuestions = await remoteDataSource.getQuestions(page: page);
      await localDataSource.cacheQuestions(remoteQuestions);
      return remoteQuestions;
    } else {
      final cachedQuestions = await localDataSource.getCachedQuestions();
      return cachedQuestions.isEmpty
          ? await remoteDataSource.getQuestions(page: page)
          : cachedQuestions;
    }
  }
}