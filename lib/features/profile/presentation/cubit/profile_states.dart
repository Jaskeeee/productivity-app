import 'package:productivity_app/features/profile/domain/model/profile_model.dart';

sealed class ProfileStates {}
class ProfileInitial extends ProfileStates{}
class ProfileLoaded extends ProfileStates{
  final ProfileModel? profile;
  ProfileLoaded({
    required this.profile
  });
}
class ProfileLoading extends ProfileStates{}
class ProfileError extends ProfileStates{
  final String message;
  ProfileError({
    required this.message
  });
}