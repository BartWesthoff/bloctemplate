part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    required this.status,
    this.user = AppUser.empty,
  });

  const AuthenticationState.authenticated(AppUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final AppUser user;

  @override
  List<Object> get props => [status, user];
}
