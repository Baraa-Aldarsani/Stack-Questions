// import 'package:dio/dio.dart';
// import 'package:stack_questions_app/features/questions/data/model/question_model.dart';

// abstract class QuestionRemoteDataSource {
//   Future<List<QuestionModel>> getQuestions({int page});
// }

// class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
//   final Dio dio = Dio();

//   @override
//   Future<List<QuestionModel>> getQuestions({int page = 1}) async {
//     print("page =============== 1$page");
//     try {
//       print("page =============== $page");
//       final response = await dio.get(
//         'https://api.stackexchange.com/2.3/questions?page=$page&pagesize=20&order=desc&sort=activity&site=stackoverflow&filter=withbody',
//       );

//       if (response.statusCode == 200) {
//         final items = response.data['items'] as List;

//         return items.map((json) => QuestionModel.fromJson(json)).toList();
//       } else {
//         throw Exception('Failed to load questions');
//       }
//     } catch (e) {
//       throw Exception('Error occurred while fetching questions: $e');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stack_questions_app/features/questions/data/model/question_model.dart';

abstract class QuestionRemoteDataSource {
  Future<List<QuestionModel>> getQuestions({int page});
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final http.Client client = http.Client();

  @override
  Future<List<QuestionModel>> getQuestions({int page = 1}) async {
    print("$page");

    try {
      final Uri url = Uri.parse(
        'https://api.stackexchange.com/2.3/questions?page=$page&pagesize=20&order=desc&sort=activity&site=stackoverflow&filter=withbody',
      );
     

      final response = await client.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final items = data['items'] as List;

        return items.map((json) => QuestionModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching questions: $e');
    }
  }
}
