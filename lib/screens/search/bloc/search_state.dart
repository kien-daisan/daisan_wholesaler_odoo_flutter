import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/SearchScreenModel.dart';

abstract class SearchState {
}

class SearchInitialState extends SearchState{}

class SearchScreenSuccess extends SearchState{
  final SearchScreenModel? searchSuggestionModel;

   SearchScreenSuccess(this.searchSuggestionModel);
}


class SearchActionState extends SearchState{
}

class SearchEmptyState extends SearchState{
}

class SearchScreenError extends SearchState {
   SearchScreenError(this.message);

 final String message;
}