import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_questions_app/features/questions/domain/entities/question.dart';
import '../../domain/usecases/get_questions.dart';
import 'question_event.dart';
import 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final GetQuestions getQuestions;
  int currentPage = 1;
  bool hasReachedMax = false;
  List<Question> allQuestions = [];

  QuestionBloc({required this.getQuestions}) : super(QuestionInitial()) {
    on<FetchQuestionsEvent>((event, emit) async {
      emit(QuestionLoading());
      try {
        final questions = await getQuestions(page: 1);
        allQuestions = questions;
        currentPage = 1;
        hasReachedMax = questions.length < 20;
        emit(QuestionLoaded(questions, hasReachedMax: hasReachedMax));
      } catch (e) {
        emit(
          QuestionError(
            "Error occurred while fetching questions: ${e.toString()}",
          ),
        );
      }
    });

    on<LoadMoreQuestionsEvent>((event, emit) async {
      if (hasReachedMax) return;
      try {
        final nextPage = currentPage + 1;
        final questions = await getQuestions(page: nextPage);
        currentPage = nextPage;
        hasReachedMax = questions.length < 20;
        allQuestions.addAll(questions);
        emit(QuestionLoaded(allQuestions, hasReachedMax: hasReachedMax));
      } catch (e) {
        emit(QuestionError(e.toString()));
      }
    });
  }
}
