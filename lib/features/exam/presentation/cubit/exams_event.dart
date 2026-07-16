sealed class ExamsEvent {}

class GetExamsEvent extends ExamsEvent {}
class LoadMoreExamsEvent extends ExamsEvent {}

class GetSubjectsEvent extends ExamsEvent {}
class LoadMoreSubjectsEvent extends ExamsEvent {}

sealed class ExamsUiEvent {}