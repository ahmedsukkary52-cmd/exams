import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_paths.dart';
import '../../../../core/theme/theme_app.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_outlined_button.dart';
import '../../domain/entities/question_entity.dart';
import '../widgets/score_card_widget.dart';

class ExamScorePage extends StatefulWidget {
  final List<QuestionEntity> questions;
  final Map<String, Set<String>> selectedAnswers;
  const ExamScorePage({super.key, required this.questions, required this.selectedAnswers});

  @override
  State<ExamScorePage> createState() => _ExamScorePageState();
}

class _ExamScorePageState extends State<ExamScorePage> {
  @override
  void initState() {
    super.initState();

    debugPrint('════════════ Exam Questions ═══════════=');

    for (final question in widget.questions) {
      debugPrint('Question ID: ${question.id}');
      debugPrint('Question: ${question.question}');
      debugPrint('Correct Answer: ${question.correct}');
      debugPrint('Type: ${question.type.name}');

      final selected = widget.selectedAnswers[question.id] ?? <String>{};

      debugPrint('Selected Answers: $selected');

      for (final answer in question.answers) {
        debugPrint(
          '   ${answer.key}: ${answer.answer}'
              '${selected.contains(answer.key) ? '  <-- Selected' : ''}',
        );
      }

      debugPrint('----------------------------------------');
    }

    debugPrint('════════════ Selected Answers Map ═══════════=');

    widget.selectedAnswers.forEach((questionId, answers) {
      debugPrint('$questionId -> $answers');
    });

    debugPrint('══════════════════════════════════════════════');
  }

  int get correctCount {
    int count = 0;

    for (final question in widget.questions) {
      final selected = widget.selectedAnswers[question.id] ?? <String>{};

      final correctAnswers = question.correct
          .split(',')
          .map((e) => e.trim())
          .toSet();

      if (selected.length == correctAnswers.length && selected.containsAll(correctAnswers)) {
        count++;
      }
    }

    return count;
  }

  int get incorrectCount => widget.questions.length - correctCount;

  double get percentage => widget.questions.isEmpty
          ? 0
          : correctCount / widget.questions.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeApp.colors.whiteColor,
      appBar: AppBar(
        backgroundColor: ThemeApp.colors.whiteColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.go(
            RoutePaths.examDetails,
            extra: widget.questions[0].exam,
          ),
        ),
        title: Text(
          'Exam score',
          style: ThemeApp.text.medium20black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScoreCardWidget(
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                percentage: percentage,
              ),

              SizedBox(height: 80.h),

              AppElevatedButton(
                  text: 'Show results',
                  onPressed:() => context.go(RoutePaths.answers)
              ),

              SizedBox(height: 24.h),

              AppOutlinedButton(
                text: 'Start again',
                onPressed: () => context.go(
                  RoutePaths.examDetails,
                  extra: widget.questions[0].exam,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}