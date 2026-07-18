import 'package:exams/core/widgets/app_search_field.dart';
import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/cubit/exams_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/theme_app.dart';
import '../../widgets/subjects_list_builder.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  ExamsCubit get examsCubit => context.read<ExamsCubit>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pixels = _scrollController.position;

    if (pixels.extentAfter < 200) {
      examsCubit.doEvent(LoadMoreSubjectsEvent());
    }
  }

  Future<void> _onRefresh() async {
    await examsCubit.doEvent(GetSubjectsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
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
              sliver: SubjectsListBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}