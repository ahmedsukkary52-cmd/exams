import 'package:exams/core/base/resources.dart';
import 'package:exams/core/di/di.dart';
import 'package:exams/core/widgets/app_search_field.dart';
import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/cubit/exams_event.dart';
import 'package:exams/features/exam/presentation/cubit/exams_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../widgets/subject_card.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ExamsCubit examsCubit = getIt<ExamsCubit>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    examsCubit.doEvent(GetExamsEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      examsCubit.doEvent(LoadMoreExamsEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    examsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: examsCubit,
      child: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 0,
              backgroundColor: ThemeApp.colors.whiteColor,
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Text(
                'Survey',
                style: ThemeApp.text.medium20blue,
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverToBoxAdapter(
                child: AppSearchField(
                  controller: _searchController,
                  hintText: 'Search',
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Browse by subject',
                  style: ThemeApp.text.medium18black,
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                16.h,
                16.w,
                24.h,
              ),
              sliver: BlocBuilder<ExamsCubit, ExamsState>(
                builder: (context, state) {
                  switch (state.examsResource.status) {
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
                      final exams = state.examsResource.data!;

                      return SliverList.separated(
                        itemCount: exams.length + (state.paginationResource.status == Status.loading
                                ? 1
                                : 0),
                        separatorBuilder: (_, _) => SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          if (index == exams.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final exam = exams[index];

                          return SubjectCard(
                            title: exam.title,
                            onTap: () {
                              // to later
                            },
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}