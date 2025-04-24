import 'package:flutter/material.dart';
import '../../domain/entities/question.dart';

class QuestionDetailScreen extends StatelessWidget {
  final Question question;

  const QuestionDetailScreen({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(question.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.title,
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                question.body,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
