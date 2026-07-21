enum QuestionType {
  single,
  multiple;

  static QuestionType fromString({required String questionTypeStr}) {
    switch(questionTypeStr) {
      case 'single_choice':
        return QuestionType.single;
      case 'multiple_choice':
        return QuestionType.multiple;
      default:
        return QuestionType.single;
    }
  }
}