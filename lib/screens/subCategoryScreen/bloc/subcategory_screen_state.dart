import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';

abstract class SubCategoryState extends Equatable{
  const SubCategoryState();

  @override
  List<Object> get props => [];
}

class SubCategoryInitialState extends SubCategoryState{

}

class SubCategorySuccessState extends SubCategoryState{
  CategoryScreenModel? categoryScreenModel;
  SubCategorySuccessState(this.categoryScreenModel);
}

class SubCategoryErrorState extends SubCategoryState{
  SubCategoryErrorState(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}