

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Html(
                data: question.body,
                style: {
                  "p": Style(fontSize: FontSize.large, color: Colors.grey[800]),
                  "pre": Style(
                    backgroundColor: Colors.grey[200],
                    padding: HtmlPaddings.all(8),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  "code": Style(
                    fontFamily: 'monospace',
                    backgroundColor: Colors.grey[100],
                    padding: HtmlPaddings.all(4),
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
