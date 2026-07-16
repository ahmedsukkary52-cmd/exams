import 'package:exams/features/exam/presentation/widgets/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/base/resources.dart';
import '../cubit/exams_cubit.dart';
import '../cubit/exams_state.dart';

class SubjectsListBuilder extends StatelessWidget {
  const SubjectsListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamsCubit, ExamsState>(
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
            final subjects = state.subjectsResource.data!;

            return SliverList.separated(
              itemCount: subjects.length + (state.metaSubjects.status == Status.loading
                  ? 1
                  : 0),
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
                    // to later
                  },
                );
              },
            );
        }
      },
    );
  }
}
