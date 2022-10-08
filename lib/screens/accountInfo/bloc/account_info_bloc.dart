import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_events.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_repository.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_state.dart';

class AccountInfoBloc extends Bloc<AccountInfoEvent, AccountInfoState> {
  AccountInfoRepositoryImp? repository;

  AccountInfoBloc({this.repository}) : super(AccountInfoInitialState()) {
    on<AccountInfoEvent>(mapEventToState);
  }

  void mapEventToState(
      AccountInfoEvent event, Emitter<AccountInfoState> emit) async {
    if (event is SaveAccountInfoEvent) {
      emit(AccountInfoLoadingState());
      try {
        var model = await repository?.saveAccountInfo(
            event.name ?? '', event.password ?? '');
        if (model != null) {
          emit(AccountInfoSuccessState(model));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is DeactivateAccount) {
      emit(AccountInfoLoadingState());
      try {
        var model = await repository?.deactivateAccount(event.type);
        if (model != null) {
          emit(AccountInfoDeactivateState(model));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is DownloadInformationEvent) {
      emit(AccountInfoLoadingState());
      try {
        var model = await repository?.downloadAccountInfo();
        if (model != null) {
          emit(AccountInfoDownloadSuccessState(model));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is ReSendVerificationEvent) {
      emit(AccountInfoLoadingState());
      try {
        var model = await repository?.resendVerificationMail();
        if (model != null) {
          emit(ResendVerificationSuccessState(model));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is DeleteAccountLoginEvent) {
      emit(AccountInfoLoadingState());
      try {
        var model = await repository?.loginUser(
            event.email ?? "", event.password ?? "");
        if (model != null) {
          emit(DeleteLoginSuccessState(model));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
    else if (event is DeleteAccountEvent) {
      emit(AccountInfoLoadingState());
      try {
        var model = await repository?.deleteAccount();
        if (model != null) {
          emit(DeleteAccountSuccess(model));
        } else {
          emit(const AccountInfoErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(AccountInfoErrorState(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
  }
}
