class ExamEntity {
  final String id;
  final String title;
  final int duration;
  final String subjectId;
  final int numberOfQuestions;
  final bool active;
  final DateTime createdAt;

  const ExamEntity({
    required this.id,
    required this.title,
    required this.duration,
    required this.subjectId,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  ExamEntity.empty():
        id = '',
        title = '',
        duration = 0,
        subjectId = '',
        numberOfQuestions = 0,
        active = false,
        createdAt = DateTime.fromMillisecondsSinceEpoch(0);
}