part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = AppUser.empty,
  });

  const AuthState.authenticated(AppUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final AppUser user;

  @override
  List<Object> get props => [status, user];
}
