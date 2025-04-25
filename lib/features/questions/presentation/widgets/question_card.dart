import 'package:flutter/material.dart';
import 'package:stack_questions_app/features/questions/domain/entities/question.dart';
import 'package:stack_questions_app/features/questions/presentation/screens/question_detail_screen.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int index;

  const QuestionCard({super.key, required this.question, required this.index});

  @override
  Widget build(BuildContext context) {
    final isEven = index % 2 == 0;
    final gradientColors =
        isEven
            ? [Color(0xFF89CFF0), Color(0xFF9D7DF9)]
            : [Color(0xFFFFD3B6), Color(0xFFFF8FAB)];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(2, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          title: Text(
            question.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 2, color: Colors.black38)],
            ),
          ),
          subtitle: Text(
            _truncateText(_stripHtmlTags(question.body)),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: index % 2 == 0 ? Colors.blue[900] : Colors.orange[900],
            ),
          ),
          trailing: const Icon(Icons.expand_more, color: Colors.white),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white.withOpacity(0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _truncateText(_stripHtmlTags(question.body)),
                    maxLines: 15,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true, // التأكد من التفاف النص
                    style: TextStyle(
                      color:
                          index % 2 == 0
                              ? Colors.blue[900]
                              : Colors.orange[900],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (_, animation, __) =>
                                    QuestionDetailScreen(question: question),
                            transitionsBuilder: (_, animation, __, child) {
                              final tween = Tween(
                                begin: const Offset(1, 0),
                                end: Offset.zero,
                              ).chain(CurveTween(curve: Curves.easeInOut));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: const Text("Read More"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _stripHtmlTags(String htmlText) {
    final RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '').replaceAll('&nbsp;', ' ').trim();
  }

  String _truncateText(String text, [int maxLength = 120]) {
    return (text.length <= maxLength)
        ? text
        : '${text.substring(0, maxLength)}...';
  }
}
