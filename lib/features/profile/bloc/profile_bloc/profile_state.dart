
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {
  
}

class ProfileSuccess extends ProfileState {
  
  // final UserProfile user_profile;
  // ProfileSuccess({required this.user_profile});

  ProfileSuccess();

  @override
  // List<Object> get props => [user_profile];
  List<Object> get props => [];
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}

class ProfileLoading extends ProfileState {}


