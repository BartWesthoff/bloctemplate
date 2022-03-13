part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginWithCredentials extends LoginEvent {
  const LoginWithCredentials();

  @override
  List<Object?> get props => [];
}

class LoginWithGoogle extends LoginEvent {
  const LoginWithGoogle();

  @override
  List<Object?> get props => [];
}
