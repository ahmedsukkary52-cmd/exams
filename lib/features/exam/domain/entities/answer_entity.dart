class AnswerEntity {
  final String answer;
  final String key;

  const AnswerEntity({
    required this.answer,
    required this.key,
  });

  AnswerEntity copyWith({
    String? answer,
    String? key,
  }) {
    return AnswerEntity(
      answer: answer ?? this.answer,
      key: key ?? this.key,
    );
  }
}