import 'dart:async';
import 'package:exams/features/exam/domain/entities/subjects_response_entity.dart';
import 'package:exams/features/exam/domain/use_cases/get_subjects_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base/resources.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/entities/exams_response_entity.dart';
import '../../domain/use_cases/get_all_exams_use_case.dart';
import '../../domain/use_cases/get_exams_by_subject_use_case.dart';
import 'exams_event.dart';
import 'exams_state.dart';

@injectable
class ExamsCubit extends Cubit<ExamsState> {
  final GetAllExamsUseCase _getExamsUseCase;
  final GetSubjectsUseCase _getSubjectsUseCase;
  final GetExamsBySubjectUseCase _getExamsBySubjectUseCase;

  ExamsCubit(
      this._getExamsUseCase,
      this._getSubjectsUseCase,
      this._getExamsBySubjectUseCase,
      ) : super(
    const ExamsState(
      examsResource: Resource.initial(),
      subjectsResource: Resource.initial(),
      examsBySubjectsResource: Resource.initial(),
      isLoadingMoreExams: false,
      isLoadingMoreSubjects: false,
      isLoadingMoreExamsBySubjects: false,
    ),
  );

  final StreamController<void> _uiController = StreamController<void>.broadcast();
  Stream<void> get uiStream => _uiController.stream;
  String? _selectedSubjectId;

  Future<void> doEvent(ExamsEvent event) async {
    switch (event) {
      case GetExamsEvent():
        await _getExams(event);
        break;

      case LoadMoreExamsEvent():
        await _loadMoreExams(event);
        break;

      case GetSubjectsEvent():
        await _getSubjects(event);
        break;

      case LoadMoreSubjectsEvent():
        await _loadMoreSubjects(event);
        break;

      case GetExamsBySubjectEvent():
        await _getExamsBySubject(event);
        break;

      case LoadMoreExamsBySubjectEvent():
        await _loadMoreExamsBySubject(event);
        break;
    }
  }


  Future<void> _getExamsBySubject(GetExamsBySubjectEvent event) async {
    _selectedSubjectId = event.subjectId;

    emit(state.copyWith(examsBySubjectsResource: const Resource.loading()));

    final response = await _getExamsBySubjectUseCase(subjectId: event.subjectId);

    switch (response) {
      case Success<ExamsResponseEntity>():
        emit(state.copyWith(examsBySubjectsResource: Resource.success(response.data)));
        break;

      case Failure<ExamsResponseEntity>():
        emit(
          state.copyWith(examsBySubjectsResource: Resource.error(
              message: response.error.message,
              exception: response.error.exception,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _loadMoreExamsBySubject(LoadMoreExamsBySubjectEvent event) async {
    if (state.isLoadingMoreExamsBySubjects) return;

    if (_selectedSubjectId == null) return;

    final current = state.examsBySubjectsResource.data;

    if (current == null || !current.hasMore) return;

    emit(state.copyWith(isLoadingMoreExamsBySubjects: true));

    try {
      final response = await _getExamsBySubjectUseCase(
        subjectId: _selectedSubjectId!,
        page: current.nextPage,
      );

      if (isClosed) return;

      switch (response) {
        case Success<ExamsResponseEntity>():
          emit(
            state.copyWith(
              isLoadingMoreExamsBySubjects: false,
              examsBySubjectsResource: Resource.success(
                current.copyWith(
                  message: response.data.message,
                  metadata: response.data.metadata,
                  exams: [
                    ...current.exams,
                    ...response.data.exams,
                  ],
                ),
              ),
            ),
          );
          return;

        case Failure<ExamsResponseEntity>():
          debugPrint('Load More Exams By Subject Failed: ${response.error.message}');
          break;
      }
    } finally {
      if (!isClosed && state.isLoadingMoreExamsBySubjects) {
        emit(state.copyWith(isLoadingMoreExamsBySubjects: false));
      }
    }
  }

  Future<void> _getSubjects(GetSubjectsEvent event) async {
    emit(state.copyWith(subjectsResource: const Resource.loading()));

    final response = await _getSubjectsUseCase();

    switch (response) {
      case Success<SubjectsResponseEntity>():
        emit(state.copyWith(subjectsResource: Resource.success(response.data)));
        break;

      case Failure<SubjectsResponseEntity>():
        emit(state.copyWith(subjectsResource: Resource.error(
              message: response.error.message,
              exception: response.error.exception,
            )));
        break;
    }
  }

  Future<void> _loadMoreSubjects(LoadMoreSubjectsEvent event) async {
    if(state.isLoadingMoreSubjects) return;

    final current = state.subjectsResource.data;

    if(current == null || !current.hasMore) return;


    emit(state.copyWith(isLoadingMoreSubjects: true));

    try {
      final response = await _getSubjectsUseCase(page: current.nextPage);

      if(isClosed) return;

      switch (response) {
        case Success<SubjectsResponseEntity>():
          emit(
            state.copyWith(
              isLoadingMoreSubjects: false,
              subjectsResource: Resource.success(
                current.copyWith(
                  metadata: response.data.metadata,
                  subjects: [
                    ...current.subjects,
                    ...response.data.subjects,
                  ],
                ),
              ),
            ),
          );
          break;

        case Failure<SubjectsResponseEntity>():
          debugPrint("Load More Subjects Failed: ${response.error.message}");
          break;
      }
    } finally {
      if (!isClosed) {
        emit(state.copyWith(isLoadingMoreSubjects: false));
      }
    }
  }

  Future<void> _getExams(GetExamsEvent event) async {
    emit(state.copyWith(examsResource: const Resource.loading()));

    final response = await _getExamsUseCase();

    switch (response) {
      case Success<ExamsResponseEntity>():
        emit(state.copyWith(examsResource: Resource.success(response.data)));
        break;

      case Failure<ExamsResponseEntity>():
        emit(state.copyWith(examsResource: Resource.error(
            message: response.error.message,
            exception: response.error.exception
          )));
        break;
    }
  }

  Future<void> _loadMoreExams(LoadMoreExamsEvent event) async {
    if (state.isLoadingMoreExams) return;

    final current = state.examsResource.data;
    if (current == null || !current.hasMore) return;

    emit(state.copyWith(isLoadingMoreExams: true));

    try {
      final response = await _getExamsUseCase(page: current.nextPage);

      if (isClosed) return;

      switch (response) {
        case Success<ExamsResponseEntity>():
          emit(
            state.copyWith(
              isLoadingMoreExams: false,
              examsResource: Resource.success(
                current.copyWith(
                  metadata: response.data.metadata,
                  exams: [
                    ...current.exams,
                    ...response.data.exams,
                  ],
                ),
              ),
            ),
          );

        case Failure<ExamsResponseEntity>():
          emit(state.copyWith(isLoadingMoreExams: false));
      }
    } finally {
      if (!isClosed) {
        emit(state.copyWith(isLoadingMoreExams: false));
      }
    }
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}