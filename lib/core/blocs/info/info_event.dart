part of 'info_bloc.dart';

abstract class InfoEvent extends Equatable {
  const InfoEvent();

  @override
  List<Object> get props => [];
}

class InfoLoaded extends InfoEvent {
  final InfoModel info;

  const InfoLoaded(this.info);

  @override
  List<Object> get props => [info];
}

class InfoLoadRequested extends InfoEvent {
  final String uid;

  const InfoLoadRequested(this.uid);

  @override
  List<Object> get props => [uid];
}

class InfoUpdated extends InfoEvent {
  final InfoModel info;

  const InfoUpdated(this.info);

  @override
  List<Object> get props => [info];
}

class InfoCreateRequested extends InfoEvent {
  const InfoCreateRequested();

  @override
  List<Object> get props => [];
}

class InfoWelcomeClicked extends InfoEvent {}

class InfoSignoutRequested extends InfoEvent {}
