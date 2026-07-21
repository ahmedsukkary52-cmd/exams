import 'package:exams/core/arguments/exam_score_args.dart';
import 'package:exams/core/base/resources.dart';
import 'package:exams/core/routing/route_paths.dart';
import 'package:exams/core/theme/image_app.dart';
import 'package:exams/core/widgets/app_elevated_button.dart';
import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/cubit/exams_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/enums/question_type.dart';
import '../../../../core/theme/theme_app.dart';
import '../../domain/entities/answer_entity.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/question_entity.dart';
import '../widgets/answer_card.dart';
import '../widgets/exam_bottom_actions.dart';
import '../widgets/exam_header.dart';
import '../widgets/question_progress.dart';

class ExamSessionPage extends StatefulWidget {
  final ExamEntity exam;
  final int initialIndex;

  const ExamSessionPage({super.key, this.initialIndex = 0, required this.exam});

  @override
  State<ExamSessionPage> createState() => _ExamSessionPageState();
}

class _ExamSessionPageState extends State<ExamSessionPage> {
  bool _startTimer = false;
  late final PageController _pageController;
  late int currentQuestion;
  final Map<String, Set<String>> selectedAnswers = {};
  List<QuestionEntity> _questions = [];

  int get unansweredQuestionsCount {
    return _questions.where((question) {
      final answers = selectedAnswers[question.id];
      return answers == null || answers.isEmpty;
    }).length;
  }

  Future<void> _showSubmitDialog() async {
    final unanswered = unansweredQuestionsCount;

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: ThemeApp.colors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('Submit Exam?', style: ThemeApp.text.medium20black),
        content: Text(
          unanswered == 0
              ? 'Are you sure you want to submit your exam?'
              : 'You still have $unanswered unanswered ${unanswered == 1 ? 'question' : 'questions'}.\n\nAre you sure you want to submit anyway?',
          style: ThemeApp.text.regular16black,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ThemeApp.colors.primary,
              backgroundColor: ThemeApp.colors.primary.withValues(alpha: 0.08),
              textStyle: ThemeApp.text.medium16blue,
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          AppElevatedButton(
            text: 'Submit',
            onPressed: () {
              Navigator.pop(context);

              context.push(
                RoutePaths.examScore,
                extra: ExamScoreArgs(
                  questions: _questions,
                  selectedAnswers: selectedAnswers,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentQuestion = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _timerDialogShown = false;

  Future<void> _showTimeOutDialog() async {
    if (_timerDialogShown) return;

    _timerDialogShown = true;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: ThemeApp.colors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageApp.sendClock,
                    width: 45,
                    height: 86,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Time out !!',
                    style: ThemeApp.text.medium20black.copyWith(color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: AppElevatedButton(

                  onPressed: () {
                    Navigator.of(context).pop();

                    context.push(RoutePaths.examScore, extra: ExamScoreArgs(
                        questions: _questions,
                        selectedAnswers: selectedAnswers)
                    );
                  },
                  text: 'View score',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAnswerTap(QuestionEntity question, AnswerEntity answer) {
    final answers = selectedAnswers.putIfAbsent(question.id, () => <String>{});

    if (question.type == QuestionType.single) {
      answers..clear()..add(answer.key);
    } else {
      if (answers.contains(answer.key)) {
        answers.remove(answer.key);
      } else {
        answers.add(answer.key);
      }
    }

    setState(() {});
  }

  Future<void> goToQuestion(int index) async {
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );

    setState(() {currentQuestion = index;});
  }

  void nextQuestion(int totalQuestions) {
    if (currentQuestion == totalQuestions - 1) return;
    goToQuestion(currentQuestion + 1);
  }

  void previousQuestion() {
    if (currentQuestion == 0) return;
    goToQuestion(currentQuestion - 1);
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
      },
      child: BlocListener<ExamsCubit, ExamsState>(
        listener: (context, state) {
          if(state.questionsByExamResource.status == Status.success && !_startTimer) {
            setState(() => _startTimer = true,);
          }
        },
        child: Scaffold(
          backgroundColor: ThemeApp.colors.whiteColor,
          appBar: ExamHeader(
            duration: Duration(minutes: widget.exam.duration),
            onBack: context.pop,
            onTimeFinished: _showTimeOutDialog,
            startTimer: _startTimer,
          ),
          body: SafeArea(
            child: BlocBuilder<ExamsCubit, ExamsState>(
              builder: (context, state) {
                switch(state.questionsByExamResource.status) {
                  case Status.initial:
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());

                  case Status.error:
                    return Center(child: Text(state.questionsByExamResource.message!));

                  case Status.success:
                    _questions = state.questionsByExamResource.data!.questions;

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                          child: QuestionProgress(
                              current: currentQuestion + 1,
                              total: _questions.length
                          ),
                        ),

                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _questions.length,
                            onPageChanged: (index) {
                              setState(() {currentQuestion = index;});
                            },
                            itemBuilder: (context, pageIndex) {
                              final question = _questions[pageIndex];

                              final selected = selectedAnswers.putIfAbsent(
                                  question.id, () => <String>{}
                              );

                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 250),
                                      child: Text(
                                          question.question,
                                          key: ValueKey(question.id),
                                          style: ThemeApp.text.medium18black
                                      ),
                                    ),

                                    SizedBox(height: 24.h),

                                    Expanded(
                                      child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: question.answers.length,
                                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                                        itemBuilder: (_, answerIndex) {
                                          final answer = question.answers[answerIndex];

                                          return AnswerCard(
                                            answer: answer,
                                            type: question.type,
                                            selected: selected.contains(answer.key),
                                            onTap: () => onAnswerTap(question, answer),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                          child: ExamBottomActions(
                            hasPrevious: currentQuestion != 0,
                            isLast: currentQuestion == _questions.length - 1,
                            onBack: previousQuestion,
                            onNext: () {
                              if (currentQuestion == _questions.length - 1) {
                                _showSubmitDialog();
                                return;
                              }

                              nextQuestion(_questions.length);
                            },
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
          ),
        ),
  ),
    );
  }
}