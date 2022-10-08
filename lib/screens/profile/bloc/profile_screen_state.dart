import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';

import '../../../models/BaseModel.dart';

abstract class ProfileScreenState extends Equatable{
  const ProfileScreenState();

  @override
  List<Object> get props => [];
}

class ProfileScreenInitial extends ProfileScreenState{

}

class LoadingState extends ProfileScreenState{}

class LogOutSuccess extends ProfileScreenState{
  BaseModel? baseModel;
  LogOutSuccess(this.baseModel);

  @override
  List<Object> get props => [];
}

class AddImageState extends ProfileScreenState{
  AccountInfoModel? model;
  AddImageState(this.model);

  @override
  List<Object> get props => [];
}

class DeleteImageState extends ProfileScreenState{
  BaseModel? model;
  DeleteImageState(this.model);

  @override
  List<Object> get props => [];
}

class DeleteBannerImageState extends ProfileScreenState{
  BaseModel? model;
  DeleteBannerImageState(this.model);

  @override
  List<Object> get props => [];
}

class ProfileScreenError extends ProfileScreenState{
  String? _message;
  ProfileScreenError(this._message);

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}