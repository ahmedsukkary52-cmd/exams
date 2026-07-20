import 'package:exams/core/base/resources.dart';
import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/cubit/exams_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/route_paths.dart';
import 'exams_card.dart';

class ExamsBySubjectListBuilder extends StatelessWidget {
  const ExamsBySubjectListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsState>(
      buildWhen: (previous, current) => previous.examsBySubjectsResource != current.examsBySubjectsResource ||
          previous.isLoadingMoreExamsBySubjects != current.isLoadingMoreExamsBySubjects,
      builder: (context, state) {
        switch (state.examsBySubjectsResource.status) {
          case ResourceStatus.loading:
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case ResourceStatus.error:
            return SliverFillRemaining(
              child: Center(
                child: Text(
                  state.examsBySubjectsResource.message ?? 'Something went wrong',
                ),
              ),
            );

          case ResourceStatus.success:
            final paginatedExams = state.examsBySubjectsResource.data!;
            final exams = paginatedExams.exams;

            if (exams.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text('No exams found'),
                ),
              );
            }

            return SliverList.builder(
              itemCount: exams.length + (state.isLoadingMoreExamsBySubjects ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == exams.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final exam = exams[index];

                return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ExamCard(
                      exam: exam,
                      onTap: () => context.push(RoutePaths.examDetails,extra: exams[index])
                    ),
                  );
              },
            );

          case ResourceStatus.initial:
            return const SliverToBoxAdapter(
              child: SizedBox.shrink(),
            );
        }
      },
    );
  }
}