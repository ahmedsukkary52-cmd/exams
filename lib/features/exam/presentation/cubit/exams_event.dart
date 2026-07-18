sealed class ExamsEvent {}

class GetExamsEvent extends ExamsEvent {}
class LoadMoreExamsEvent extends ExamsEvent {}

class GetExamsBySubjectEvent extends ExamsEvent {
  final String subjectId;
  GetExamsBySubjectEvent(this.subjectId);
}
class LoadMoreExamsBySubjectEvent extends ExamsEvent {
  LoadMoreExamsBySubjectEvent();
}

class GetSubjectsEvent extends ExamsEvent {}
class LoadMoreSubjectsEvent extends ExamsEvent {}

sealed class ExamsUiEvent {}