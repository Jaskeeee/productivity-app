import 'package:productivity_app/features/auth/domain/model/app_user.dart';

sealed class AuthStates {}
class AuthInitial extends AuthStates{}
class Authenticated extends AuthStates{
  final AppUser? user;
  Authenticated({required this.user});
}
class AuthLoading extends AuthStates{}
class AuthError extends AuthStates{
  final String message;
  AuthError({required this.message});
}
class Unauthenticated extends AuthStates{}