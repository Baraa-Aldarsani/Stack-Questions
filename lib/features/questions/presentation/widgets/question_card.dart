import 'package:flutter/material.dart';
import 'package:stack_questions_app/features/questions/domain/entities/question.dart';
import 'package:stack_questions_app/features/questions/presentation/screens/question_detail_screen.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int index;

  const QuestionCard({super.key, required this.question, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      color: index % 2 == 0 ? Colors.blue[50] : Colors.orange[50],
      child: ListTile(
        title: Text(
          question.title,
          style: TextStyle(
            color: index % 2 == 0 ? Colors.blue : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          question.body,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: index % 2 == 0 ? Colors.blue[900] : Colors.orange[900],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, animation, __) =>
                  QuestionDetailScreen(question: question),
              transitionsBuilder: (_, animation, __, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                final tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
        },
      ),
    );
  }
}
