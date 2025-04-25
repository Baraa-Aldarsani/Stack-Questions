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
    try {
      final remoteQuestions = await remoteDataSource.getQuestions(page: page);
      if (page == 1) {
        await localDataSource.cacheQuestions(remoteQuestions);
      }
      return remoteQuestions;
    } catch (e) {
      print('Network error: $e, loading from cache...');
      return await localDataSource.getCachedQuestions();
    }
  } else {
    print('No internet, loading from cache...');
    return await localDataSource.getCachedQuestions();
  }
}
}
