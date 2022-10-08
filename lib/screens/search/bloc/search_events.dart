import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchSuggestionEvent extends SearchEvent{
  final String searchKey;
  const SearchSuggestionEvent(this.searchKey);

}
class InitialSearchSuggestionEvent extends SearchEvent{}

