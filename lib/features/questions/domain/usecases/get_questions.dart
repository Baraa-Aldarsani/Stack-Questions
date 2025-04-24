import '../../../../services/http_client.dart';
import '../entities/question.dart';

class GetQuestions {
  final HttpClient httpClient;

  GetQuestions({required this.httpClient});

  Future<List<Question>> call({required int page}) async {

    final response = await httpClient.get(
      '/2.3/questions?page=$page&pagesize=20&order=desc&sort=activity&site=stackoverflow&filter=withbody',
    );
    
    if (response['items'] != null) {
      return (response['items'] as List)
          .map((item) => Question.fromJson(item))
          .toList();
    } else {
      throw Exception('Unexpected response format: items not found');
    }
  }
}
