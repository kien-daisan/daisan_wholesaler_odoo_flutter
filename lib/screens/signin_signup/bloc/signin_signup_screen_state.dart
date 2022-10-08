part of 'signin_signup_screen_bloc.dart';

abstract class SigninSignupScreenState extends Equatable {
  const SigninSignupScreenState();

  @override
  List<Object> get props => [];
}

class LoadingState extends SigninSignupScreenState {}

class SignupScreenInitial extends SigninSignupScreenState {}

class SignupScreenFormSuccess extends SigninSignupScreenState {
  const SignupScreenFormSuccess(this.data);

  final SignUpScreenModel data;

  @override
  List<Object> get props => [];
}

class ForgotPasswordState extends SigninSignupScreenState {
  const ForgotPasswordState(this.data);

  final BaseModel data;


  @override
  List<Object> get props => [data];
}

class LoginState extends SigninSignupScreenState {
  const LoginState(this.data);

  final LoginResponseModel data;


  @override
  List<Object> get props => [data];
}

class FingerprintLoginState extends SigninSignupScreenState {
  const FingerprintLoginState(this.data);

  final LoginResponseModel data;

  @override
  List<Object> get props => [data];
}

// ignore: must_be_immutable
class SigninSignupScreenError extends SigninSignupScreenState {
  SigninSignupScreenError(this._message);

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

class SignUpTermSuccessState extends SigninSignupScreenState{
  final SignUpTermsModel data;
  const SignUpTermSuccessState(this.data);
}

class SignUpInitialDataState extends SigninSignupScreenState{
  final CountryListModel model;
const SignUpInitialDataState(this.model);
}

class CompleteState extends SigninSignupScreenState{}
