part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  createLoading,
  updateLoading,
  notCreated,
  created,
  updated,
  success,
  failure
}

@immutable
class ProfileState extends Equatable {
  final ProfileModel profile;
  final ProfileStatus status;

  const ProfileState(
      {required this.profile, this.status = ProfileStatus.initial});

  ProfileState copyWith({
    ProfileModel? profile,
    ProfileStatus? status,
  }) {
    return ProfileState(
        profile: profile ?? this.profile, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, profile];
}
