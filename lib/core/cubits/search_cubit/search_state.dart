part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ChaptersModel> searchedChapters;
  SearchLoaded({required this.searchedChapters});
}
class SearchLoading extends SearchState {}
class SearchError extends SearchState {}