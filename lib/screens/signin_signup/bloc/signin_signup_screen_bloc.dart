import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/models/SignUpScreenModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';
import 'package:flutter_project_structure/models/SocialLoginModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_repository.dart';

part 'signin_signup_screen_event.dart';

part 'signin_signup_screen_state.dart';

class SigninSignupScreenBloc
    extends Bloc<SigninSignupScreenEvent, SigninSignupScreenState> {
  SigninSignupScreenRepository? repository;

  SigninSignupScreenBloc({this.repository}) : super(SignupScreenInitial()) {
    on<SigninSignupScreenEvent>(mapEventToState);
  }

  void mapEventToState(
    SigninSignupScreenEvent event,
    Emitter<SigninSignupScreenState> emit,
  ) async {
    if(event is SignUpInitialEvent){
      emit(LoadingState());
      try {
        var model =
        await repository?.getCountryList();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignUpInitialDataState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
    else if (event is SignUpEvent) {
      try {
        var model =
            await repository?.signUp(event.email, event.password, event.name);
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is LoginEvent) {
      try {
        var model = await repository?.login(event.email, event.password);
        if (model != null) {
          if (model.success ?? false) {
            emit(LoginState(model));
          } else {
            emit(SigninSignupScreenError(model?.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }else if (event is FingerprintLoginEvent) {
      try {
        var model = await repository?.fingerPrintLogin(event.loginKey);
        if (model != null) {
          if (model.success ?? false) {
            emit(FingerprintLoginState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is ForgotPasswordEvent) {
      try {
        var model = await repository?.forgotPassword(event.email);
        if (model != null) {
          if (model.success ?? false) {
            emit(ForgotPasswordState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is SocialLoginEvent) {
      emit(LoadingState());
      try {
        var model = await repository?.socialLogin(event.request);
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
    else if(event is SignUpTermsEvent){
      emit(LoadingState());
      try {
        var model = await repository?.getSignUpTerms();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignUpTermSuccessState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
    else if(event is SellerSignUpTermsEvent){
      print('===================');
      emit(LoadingState());
      try {
        var model = await repository?.getSellerSignUpTerms();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignUpTermSuccessState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
  }
}
