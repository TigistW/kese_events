import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kese_events/features/profile/bloc/profile_bloc/profile_event.dart';
import 'package:kese_events/features/profile/bloc/profile_bloc/profile_state.dart';
import 'package:kese_events/features/profile/repository/user_hive_repository.dart';

import '../../../../models/user/user.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserHiveRepository userHiveRepository;
  ProfileBloc({required this.userHiveRepository})
      : super(ProfileInitialState()) {
    on<ProfileSubmitted>(
      (event, emit) async {
        emit(ProfileLoading());
        try {
          // final UserProfile profile = await profileRepository.profile();
          // UserProvider user_provider = UserProvider();
          // user_provider.setUser(profile);

          // emit(ProfileSuccess(user_profile: profile));
          emit(ProfileSuccess());
        } catch (e) {
          emit(ProfileError(error: "User not found."));
        }
      },
    );
  }
}
