import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';

import '../../../models/LoginResponseModel.dart';

abstract class AccountInfoState extends Equatable{
  const AccountInfoState();
  @override
  List<Object> get props => [];
}

class AccountInfoInitialState extends AccountInfoState{}

class AccountInfoLoadingState extends AccountInfoState{}

class AccountInfoSuccessState extends AccountInfoState{
 final AccountInfoModel data;
 const AccountInfoSuccessState(this.data);
}

class AccountInfoDeactivateState extends AccountInfoState{
 final AccountInfoModel data;
 const AccountInfoDeactivateState(this.data);
}

class AccountInfoErrorState extends AccountInfoState{
  final String message;
   const AccountInfoErrorState(this.message);
}
class AccountInfoDownloadSuccessState extends AccountInfoState{
  final AccountInfoModel data;
  const AccountInfoDownloadSuccessState(this.data);
}
class DeleteLoginSuccessState extends AccountInfoState{
  final LoginResponseModel data;
  const DeleteLoginSuccessState(this.data);
}

class DeleteAccountSuccess extends AccountInfoState{
  final BaseModel data;
  const DeleteAccountSuccess(this.data);
}

class ResendVerificationSuccessState extends AccountInfoState{
  final BaseModel data;
  const ResendVerificationSuccessState(this.data);
}

class CompleteState extends AccountInfoState{}