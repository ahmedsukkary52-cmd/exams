sealed class ExamsEvent {}

class GetExamsEvent extends ExamsEvent {}
class LoadMoreExamsEvent extends ExamsEvent {}

class GetExamsBySubjectEvent extends ExamsEvent {
  final String subjectId;
  GetExamsBySubjectEvent(this.subjectId);
}
class LoadMoreExamsBySubjectEvent extends ExamsEvent {
  String? subjectId;
  LoadMoreExamsBySubjectEvent(this.subjectId);
}

class GetSubjectsEvent extends ExamsEvent {}
class LoadMoreSubjectsEvent extends ExamsEvent {}

class GetQuestionsByExamsEvent extends ExamsEvent {
  final String examId;
  GetQuestionsByExamsEvent(this.examId);
}