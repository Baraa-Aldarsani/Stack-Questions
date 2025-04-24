
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smash_toast_plugin/smash_toast_plugin.dart';
import 'package:stack_questions_app/features/questions/presentation/widgets/error_display.dart';
import 'package:stack_questions_app/features/questions/presentation/widgets/question_list_view.dart';
import '../bloc/question_bloc.dart';
import '../bloc/question_state.dart';

class QuestionListScreen extends StatelessWidget {
  const QuestionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('stack exchange Questions')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _fetchQuestions(context);
        },
        child: const Icon(Icons.data_exploration_rounded),
      ),
      body: BlocBuilder<QuestionBloc, QuestionState>(
        builder: (context, state) {
          if (state is QuestionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuestionLoaded) {
            if (state.questions.isEmpty) {
              return const Center(child: Text('No questions available.'));
            }
            return QuestionListView(
              questions: state.questions,
              hasReachedMax: state.hasReachedMax,
            );
          } else if (state is QuestionError) {
            return const ErrorDisplay();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  static Future<void> _fetchQuestions(BuildContext context) async {
    try {
      final String? data = await SmashToastPlugin.fetchDataAndToast();
      if (data != null) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Data Fetched'),
                content: Text(data),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    } catch (e) {
      print('Plugin error: $e');
    }
  }
}
