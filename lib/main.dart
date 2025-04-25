import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stack_questions_app/features/questions/data/datasources/question_local_data_source.dart';
import 'package:stack_questions_app/features/questions/data/datasources/question_remote_data_source.dart';
import 'package:stack_questions_app/features/questions/data/repositories/question_erpositories_imp.dart';
import 'package:stack_questions_app/features/questions/domain/usecases/get_questions.dart';
import 'package:stack_questions_app/features/questions/presentation/bloc/question_event.dart';
import 'package:stack_questions_app/features/questions/presentation/screens/question_list_screen.dart';
import 'core/db/database_helper.dart';
import 'features/questions/presentation/bloc/question_bloc.dart';
import 'core/network/network_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final db = await DatabaseHelper.init();

  final localDataSource = QuestionLocalDataSourceImpl(db);
  final remoteDataSource = QuestionRemoteDataSourceImpl();
  final networkInfo = NetworkInfoImpl(Connectivity());

  final repository = QuestionRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
  );

  runApp(MyApp(repository));
}

class MyApp extends StatelessWidget {
  final QuestionRepositoryImpl repository;

  const MyApp(this.repository, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create:
            (_) =>
                QuestionBloc(getQuestions: GetQuestionsUseCase(repository))
                  ..add(FetchQuestionsEvent()),
        child: QuestionListScreen(),
      ),
    );
  }
}
