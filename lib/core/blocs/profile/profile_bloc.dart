// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:DNL/common/utils/logger.dart';
import 'package:DNL/core/models/profile_model.dart';
import 'package:DNL/core/repositories/profile_repository.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository})
      : super(ProfileState(
            profile: ProfileModel(), status: ProfileStatus.initial)) {
    on<ProfileLoadRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: ProfileStatus.loading));
        ProfileModel? profile =
            await profileRepository.getProfileById(event.uid);
        if (profile == null) {
          emit(state.copyWith(
            status: ProfileStatus.notCreated,
          ));
        } else {
          emit(state.copyWith(
            status: ProfileStatus.success,
            profile: profile,
          ));
        }
      } catch (e) {
        logger.e("ProfileLoadRequested error $e");
        emit(state.copyWith(status: ProfileStatus.failure));
      }
    });

    on<ProfileUpdated>((event, emit) async {
      emit(state.copyWith(profile: event.profile));
    });

    on<ProfileCreateRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: ProfileStatus.createLoading));
        ProfileModel? newlyCreatedProfile =
            await profileRepository.createProfile(state.profile);
        emit(ProfileState(
          status: ProfileStatus.created,
          profile: newlyCreatedProfile!,
        ));
      } catch (e) {
        emit(state.copyWith(status: ProfileStatus.failure));
      }
    });

    on<ProfileWelcomeClicked>((event, emit) async {
      emit(state.copyWith(
        status: ProfileStatus.success,
      ));
    });

    on<ProfileSignoutRequested>((event, emit) async {
      emit(
          ProfileState(profile: ProfileModel(), status: ProfileStatus.initial));
    });
  }
}
