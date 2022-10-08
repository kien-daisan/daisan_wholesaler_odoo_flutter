part of 'signin_signup_screen_bloc.dart';

abstract class SigninSignupScreenEvent extends Equatable {
  const SigninSignupScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvent extends SigninSignupScreenEvent {
  const LoadingEvent();
}

class ForgotPasswordEvent extends SigninSignupScreenEvent {
  const ForgotPasswordEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginEvent extends SigninSignupScreenEvent {
  const LoginEvent(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class FingerprintLoginEvent extends SigninSignupScreenEvent {
  const FingerprintLoginEvent(this.loginKey);

  final String loginKey;

  @override
  List<Object> get props => [loginKey];
}

class SignUpEvent extends SigninSignupScreenEvent {
  const SignUpEvent(this.email, this.password, this.name);

  final String email;
  final String password;
  final String name;

  @override
  List<Object> get props => [email, password];
}

class SocialLoginEvent extends SigninSignupScreenEvent {
  const SocialLoginEvent(this.request);

  final SocialLoginModel request;

  @override
  List<Object> get props => [request];
}

class SignUpTermsEvent extends SigninSignupScreenEvent{
  const SignUpTermsEvent();
}

class SignUpInitialEvent  extends SigninSignupScreenEvent{
  const SignUpInitialEvent();
}

class SellerSignUpTermsEvent extends SigninSignupScreenEvent{
  const SellerSignUpTermsEvent();
}

