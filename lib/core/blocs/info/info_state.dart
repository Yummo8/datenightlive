part of 'info_bloc.dart';

enum InfoStatus {
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
class InfoState extends Equatable {
  final InfoModel info;
  final InfoStatus status;

  const InfoState({required this.info, this.status = InfoStatus.initial});

  InfoState copyWith({
    InfoModel? info,
    InfoStatus? status,
  }) {
    return InfoState(info: info ?? this.info, status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status, info];
}
