import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/questions/domain/usecases/get_questions.dart';
import 'features/questions/presentation/bloc/question_bloc.dart';
import 'features/questions/presentation/bloc/question_event.dart';
import 'features/questions/presentation/screens/question_list_screen.dart';
import 'services/http_client.dart';

void main() {
  final httpClient = HttpClient(baseUrl: 'https://api.stackexchange.com');
  runApp(MyApp(httpClient: httpClient));
}

class MyApp extends StatelessWidget {
  final HttpClient httpClient;

  const MyApp({super.key, required this.httpClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Stack Questions',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create:
            (_) =>
                QuestionBloc(getQuestions: GetQuestions(httpClient: httpClient))
                  ..add(FetchQuestionsEvent()),
        child: QuestionListScreen(),
      ),
    );
  }
}
