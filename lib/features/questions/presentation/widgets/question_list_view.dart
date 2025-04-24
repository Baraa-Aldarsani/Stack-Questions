import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_questions_app/features/questions/domain/entities/question.dart';
import 'package:stack_questions_app/features/questions/presentation/bloc/question_bloc.dart';
import 'package:stack_questions_app/features/questions/presentation/bloc/question_event.dart';
import 'package:stack_questions_app/features/questions/presentation/widgets/question_card.dart';

class QuestionListView extends StatelessWidget {
  final List<Question> questions;
  final bool hasReachedMax;

  const QuestionListView({
    super.key,
    required this.questions,
    required this.hasReachedMax,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (!hasReachedMax &&
            scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          context.read<QuestionBloc>().add(LoadMoreQuestionsEvent());
        }
        return false;
      },
      child: ListView.separated(
        itemCount: questions.length + (hasReachedMax ? 0 : 1),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          if (index == questions.length) {
            return const Center(child: CircularProgressIndicator());
          }
          return QuestionCard(question: questions[index], index: index);
        },
      ),
    );
  }
}
