part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileEvent {
  final ProfileModel profile;
  
  const ProfileLoaded(this.profile);
  
  @override
  List<Object> get props => [profile];
}

class ProfileLoadRequested extends ProfileEvent {
  final String uid;

  const ProfileLoadRequested(this.uid);

  @override
  List<Object> get props => [uid];
}

class ProfileUpdated extends ProfileEvent {
  final ProfileModel profile;
  
  const ProfileUpdated(this.profile);
  
  @override
  List<Object> get props => [profile];
}

class ProfileCreateRequested extends ProfileEvent {

  const ProfileCreateRequested();

  @override
  List<Object> get props => [];
}

class ProfileWelcomeClicked extends ProfileEvent {}

class ProfileSignoutRequested extends ProfileEvent {}

