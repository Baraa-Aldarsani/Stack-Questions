import 'package:equatable/equatable.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object?> get props => [];
}

class FetchQuestionsEvent extends QuestionEvent {}

class LoadMoreQuestionsEvent extends QuestionEvent {}
