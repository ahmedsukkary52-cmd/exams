import 'package:exams/core/base/resources.dart';
import 'package:exams/core/di/di.dart';
import 'package:exams/features/exam/presentation/cubit/exams_cubit.dart';
import 'package:exams/features/exam/presentation/cubit/exams_event.dart';
import 'package:exams/features/exam/presentation/cubit/exams_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final ExamsCubit examsCubit = getIt();

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    examsCubit.doEvent(GetExamsEvent());

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        examsCubit.doEvent(LoadMoreExamsEvent());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    examsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: examsCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exams'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            examsCubit.doEvent(LoadMoreExamsEvent());
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<ExamsCubit, ExamsState>(
          builder: (context, state) {
            switch (state.examsResource.status) {
              case Status.initial:
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );

              case Status.error:
                return Center(
                  child: Text(
                    state.examsResource.message ?? 'Error',
                  ),
                );

              case Status.success:
                final exams = state.examsResource.data!;

                return ListView.builder(
                  controller: _controller,
                  itemCount: exams.length +
                      (state.paginationResource.status == Status.loading
                          ? 1
                          : 0),
                  itemBuilder: (context, index) {
                    if (index == exams.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final exam = exams[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text(exam.title),
                        subtitle: Text(exam.subject),
                        trailing: Text('${exam.duration} min'),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}