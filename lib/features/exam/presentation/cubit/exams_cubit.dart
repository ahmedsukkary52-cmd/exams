import 'dart:async';
import 'package:exams/features/exam/domain/entities/paginated_subjects_entity.dart';
import 'package:exams/features/exam/domain/use_cases/get_subjects_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/base/meta_resources.dart';
import '../../../../core/base/resources.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/paginated_exams_entity.dart';
import '../../domain/entities/subject_entity.dart';
import '../../domain/use_cases/get_all_exams_use_case.dart';
import 'exams_event.dart';
import 'exams_state.dart';

@injectable
class ExamsCubit extends Cubit<ExamsState> {
  final GetAllExamsUseCase _getExamsUseCase;
  final GetSubjectsUseCase _getSubjectsUseCase;

  ExamsCubit(this._getExamsUseCase, this._getSubjectsUseCase) : super(
    const ExamsState(
      examsResource: Resource.initial(),
      metaExams: MetaResource.initial(),
      subjectsResource: Resource.initial(),
      metaSubjects: MetaResource.initial(),
    ),
  );

  final StreamController<void> _uiController = StreamController<void>.broadcast();
  Stream<void> get uiStream => _uiController.stream;


  Future<void> doEvent(ExamsEvent event) async {
    switch (event) {
      case GetExamsEvent():
        await _getExams(event);

      case LoadMoreExamsEvent():
        await _loadMoreExams(event);

      case GetSubjectsEvent():
        await _getSubjects(event);

      case LoadMoreSubjectsEvent():
        await _loadMoreSubjects(event);
    }
  }


  Future<void> _getSubjects(GetSubjectsEvent event) async {
    emit(state.copyWith(subjectsResource: Resource.loading()));

    final response = await _getSubjectsUseCase(page: 1);

    switch(response) {
      case Success<PaginatedSubjectsEntity>():
        emit(state.copyWith(
          subjectsResource: Resource.success(response.data.subjects),
          metaSubjects: MetaResource.success(response.data),)
        );
        break;
      case Failure<PaginatedSubjectsEntity>():
        emit(state.copyWith(
          subjectsResource: Resource.error(
            exception: response.error.exception,
            message: response.error.message
          )
        ));
        break;

    }
  }

  Future<void> _loadMoreSubjects(LoadMoreSubjectsEvent event) async {
    final subjectsPagination = state.metaSubjects.data;

    if(
      subjectsPagination == null ||
      !state.metaSubjects.hasMore ||
      state.metaSubjects.status == Status.loading
    ) {
      return;
    }

    final currentSubjects = List<SubjectEntity>.from(state.subjectsResource.data ?? []);

    emit(state.copyWith(metaSubjects: MetaResource.loading(data: subjectsPagination)));

    final response = await _getSubjectsUseCase(page: subjectsPagination.nextPage);

    switch(response) {
      case Success<PaginatedSubjectsEntity>():
        final updatedSubjects = [
          ...currentSubjects,
          ...response.data.subjects
        ];

        emit(state.copyWith(
          subjectsResource: Resource.success(updatedSubjects),
          metaSubjects: MetaResource.success(response.data)
        ));
        break;
      case Failure<PaginatedSubjectsEntity>():
        emit(state.copyWith(
          metaSubjects: MetaResource.error(
            data: subjectsPagination,
            exception: response.error.exception,
            message: response.error.message
          )
        ));
        break;
    }
  }

  Future<void> _getExams(GetExamsEvent event) async {
    emit(
      state.copyWith(
        examsResource: const Resource.loading(),
      ),
    );

    final response = await _getExamsUseCase(
      page: 1,
    );

    switch (response) {
      case Success<PaginatedExamsEntity>():
        emit(
          state.copyWith(
            examsResource: Resource.success(
              response.data.exams,
            ),
            metaExams: MetaResource.success(
              response.data,
            ),
          ),
        );
        break;

      case Failure<PaginatedExamsEntity>():
        emit(
          state.copyWith(
            examsResource: Resource.error(
              message: response.error.message,
              exception: response.error.exception,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _loadMoreExams(LoadMoreExamsEvent event) async {
    final examsPagination = state.metaExams.data;

    if (
      examsPagination == null ||
      !state.metaExams.hasMore ||
      state.metaExams.status == Status.loading
    ) {
      return;
    }

    final currentExams = List<ExamEntity>.from(
      state.examsResource.data ?? [],
    );

    emit(
      state.copyWith(
        metaExams: MetaResource.loading(
          data: examsPagination,
        ),
      ),
    );

    final response = await _getExamsUseCase(
      page: examsPagination.nextPage,
    );

    switch(response) {
      case Success<PaginatedExamsEntity>():
        final updatedList = [
          ...currentExams,
          ...response.data.exams,
        ];

        emit(
          state.copyWith(
            examsResource: Resource.success(updatedList,),
            metaExams: MetaResource.success(
              response.data,
            ),
          ),
        );
        break;

      case Failure<PaginatedExamsEntity>():
        emit(
          state.copyWith(
            metaExams: MetaResource.error(
              data: examsPagination,
              message: response.error.message,
              exception: response.error.exception,
            ),
          ),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}