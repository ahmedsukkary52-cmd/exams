import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/cubit/exams_event.dart';
import 'package:exams/features/exam/presentation/widgets/exams_by_subject_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_app.dart';
import '../../domain/entities/subject_entity.dart';

class SubjectDetailsPage extends StatefulWidget {
  final SubjectEntity subject;
  const SubjectDetailsPage({super.key, required this.subject});

  @override
  State<SubjectDetailsPage> createState() => _SubjectDetailsPageState();
}

class _SubjectDetailsPageState extends State<SubjectDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  ExamsCubit get examsCubit => context.read<ExamsCubit>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if(!_scrollController.hasClients) return;
    final position = _scrollController.position;

    if (position.extentAfter > 200) {
      examsCubit.doEvent(LoadMoreExamsBySubjectEvent(widget.subject.id));
    }
  }

  Future<void> _refresh() async {
    await examsCubit.doEvent(GetExamsBySubjectEvent(widget.subject.id));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      backgroundColor: ThemeApp.colors.whiteColor,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsetsGeometry.all(16.w),
              sliver: ExamsBySubjectListBuilder(),
            )
          ]
        )
      ),
    );
  }
}