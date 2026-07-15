import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/meta_resources.dart';
import '../../../../core/base/resources.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/entities/exam_entity.dart';
import '../../domain/entities/paginated_exams_entity.dart';
import '../../domain/use_cases/get_all_exams_use_case.dart';
import 'exams_event.dart';
import 'exams_state.dart';

@injectable
class ExamsCubit extends Cubit<ExamsState> {
  final GetAllExamsUseCase _allExamsUseCase;

  static const int _limit = 9;

  ExamsCubit(this._allExamsUseCase)
      : super(
    const ExamsState(
      examsResource: Resource.initial(),
      paginationResource: MetaResource.initial(),
    ),
  );

  final StreamController<void> _uiController =
  StreamController<void>.broadcast();

  Stream<void> get uiStream => _uiController.stream;


  Future<void> doEvent(ExamsEvent event) async {
    debugPrint("================ EVENT =================");

    switch (event) {
      case GetExamsEvent():
        debugPrint("EVENT => Get Exams");
        await _getExams(event);


      case LoadMoreExamsEvent():
        debugPrint("EVENT => Load More Exams");
        await _loadMoreExams(event);
    }

    debugPrint("========================================");
  }



  Future<void> _getExams(GetExamsEvent event) async {
    debugPrint("================ GET EXAMS ================");
    debugPrint("Request => page: 1");
    debugPrint("Request => limit: $_limit");


    emit(
      state.copyWith(
        examsResource: const Resource.loading(),
      ),
    );


    final response = await _allExamsUseCase(
      page: 1,
      limit: _limit,
    );


    switch (response) {

      case Success<PaginatedExamsEntity>():

        debugPrint("GET EXAMS SUCCESS");

        debugPrint(
          "Current Page : ${response.data.metadata.currentPage}",
        );

        debugPrint(
          "Total Pages  : ${response.data.metadata.numberOfPages}",
        );

        debugPrint(
          "Limit        : ${response.data.metadata.limit}",
        );

        debugPrint(
          "Exams Count  : ${response.data.exams.length}",
        );

        debugPrint(
          "Has More     : ${response.data.hasMore}",
        );


        emit(
          state.copyWith(
            examsResource: Resource.success(
              response.data.exams,
            ),
            paginationResource: MetaResource.success(
              response.data,
            ),
          ),
        );


        break;



      case Failure<PaginatedExamsEntity>():

        debugPrint("GET EXAMS FAILED");

        debugPrint(
          "Message : ${response.error.message}",
        );

        debugPrint(
          "Exception : ${response.error.exception}",
        );


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


    debugPrint("============================================");
  }




  Future<void> _loadMoreExams(
      LoadMoreExamsEvent event,
      ) async {


    debugPrint("================ LOAD MORE =================");


    final pagination = state.paginationResource.data;


    debugPrint(
      "Current Page : ${pagination?.metadata.currentPage}",
    );

    debugPrint(
      "Next Page    : ${pagination?.nextPage}",
    );

    debugPrint(
      "Has More     : ${state.paginationResource.hasMore}",
    );

    debugPrint(
      "Status       : ${state.paginationResource.status}",
    );

    debugPrint(
      "Current List : ${state.examsResource.data?.length ?? 0}",
    );



    if (pagination == null) {

      debugPrint(
        "LOAD MORE CANCELLED => Pagination is null",
      );

      return;
    }



    if (!state.paginationResource.hasMore) {

      debugPrint(
        "LOAD MORE CANCELLED => No more pages",
      );

      return;
    }



    if (state.paginationResource.status == Status.loading) {

      debugPrint(
        "LOAD MORE CANCELLED => Already loading",
      );

      return;
    }



    final currentExams = List<ExamEntity>.from(
      state.examsResource.data ?? [],
    );


    debugPrint(
      "Saving current exams: ${currentExams.length}",
    );



    emit(
      state.copyWith(
        paginationResource: MetaResource.loading(
          data: pagination,
        ),
      ),
    );



    debugPrint(
      "REQUESTING PAGE ${pagination.nextPage}",
    );

    debugPrint(
      "REQUEST LIMIT $_limit",
    );



    final response = await _allExamsUseCase(
      page: pagination.nextPage,
      limit: _limit,
    );



    switch(response) {

      case Success<PaginatedExamsEntity>():


        debugPrint("LOAD MORE SUCCESS");


        debugPrint(
          "Returned Page : ${response.data.metadata.currentPage}",
        );

        debugPrint(
          "Total Pages   : ${response.data.metadata.numberOfPages}",
        );

        debugPrint(
          "Returned Exams: ${response.data.exams.length}",
        );

        debugPrint(
          "Has More      : ${response.data.hasMore}",
        );



        final updatedList = [
          ...currentExams,
          ...response.data.exams,
        ];



        debugPrint(
          "Old Count : ${currentExams.length}",
        );

        debugPrint(
          "New Count : ${updatedList.length}",
        );



        emit(
          state.copyWith(
            examsResource: Resource.success(
              updatedList,
            ),
            paginationResource: MetaResource.success(
              response.data,
            ),
          ),
        );


        break;




      case Failure<PaginatedExamsEntity>():


        debugPrint("LOAD MORE FAILED");


        debugPrint(
          "Message : ${response.error.message}",
        );

        debugPrint(
          "Exception : ${response.error.exception}",
        );



        emit(
          state.copyWith(
            paginationResource: MetaResource.error(
              data: pagination,
              message: response.error.message,
              exception: response.error.exception,
            ),
          ),
        );


        break;
    }


    debugPrint("============================================");
  }



  @override
  Future<void> close() {
    _uiController.close();
    return super.close();
  }
}