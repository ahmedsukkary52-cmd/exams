import 'package:exams/features/exam/presentation/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/base/resources.dart';
import '../../../../core/routing/route_paths.dart';
import '../cubit/exams_cubit.dart';
import '../cubit/exams_state.dart';

class SubjectsListBuilder extends StatelessWidget {
  const SubjectsListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsState>(
      buildWhen: (previous, current) => previous.subjectsResource != current.subjectsResource ||
          previous.isLoadingMoreSubjects != current.isLoadingMoreSubjects,
      builder: (context, state) {
        switch (state.subjectsResource.status) {
          case Status.initial:
          case Status.loading:
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case Status.error:
            return SliverFillRemaining(
              child: Center(
                child: Text('Something went wrong'),
              ),
            );

          case Status.success:
            final paginatedSubjects = state.subjectsResource.data!;
            final subjects = paginatedSubjects.subjects;

            if (subjects.isEmpty) {
              return const SliverFillRemaining(
                child: Center(
                  child: Text('No subjects found'),
                ),
              );
            }

            return SliverList.separated(
              itemCount: subjects.length + (state.isLoadingMoreSubjects ? 1 : 0),
              separatorBuilder: (_, _) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                if (index == subjects.length) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return SubjectCard(
                  subject: subjects[index],
                  onTap: () {
                    context.push(RoutePaths.subjectDetails,extra: subjects[index]);
                  },
                );
              },
            );
        }
      },
    );
  }
}
