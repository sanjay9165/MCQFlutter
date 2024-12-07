import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../models/chapter_model.dart';
import '../../repositories/mcq_repo.dart';

part 'search_state.dart';


class SearchCubit extends Cubit<SearchState> {
  final McqRepo repo;
  SearchCubit({required this.repo}) : super(SearchInitial());

  searchTest({required String value}) async{
    emit(SearchLoading());
    try{
      final List<ChaptersModel> items = await repo.searchChapter(value: value);

      emit(SearchLoaded(searchedChapters: items));

    }catch(e){

      if (kDebugMode) {
        print("ERROR IN SearchCubit = $e");
      }
    }
  }

  resetSearch(){

    emit(SearchInitial());
  }
}
