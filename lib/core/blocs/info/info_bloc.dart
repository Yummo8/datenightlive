// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:DNL/common/utils/logger.dart';
import 'package:DNL/core/models/info_model.dart';
import 'package:DNL/core/repositories/info_repository.dart';
import 'package:meta/meta.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final InfoRepository infoRepository;

  InfoBloc({required this.infoRepository})
      : super(InfoState(info: InfoModel(), status: InfoStatus.initial)) {
    on<InfoLoadRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: InfoStatus.loading));
        InfoModel? info = await infoRepository.getInfoById(event.uid);
        if (info == null) {
          emit(state.copyWith(
            status: InfoStatus.notCreated,
          ));
        } else {
          emit(state.copyWith(
            status: InfoStatus.success,
            info: info,
          ));
        }
      } catch (e) {
        logger.e("InfoLoadRequested error $e");
        emit(state.copyWith(status: InfoStatus.failure));
      }
    });

    on<InfoUpdated>((event, emit) async {
      emit(state.copyWith(info: event.info));
    });

    on<InfoCreateRequested>((event, emit) async {
      try {
        emit(state.copyWith(status: InfoStatus.createLoading));
        InfoModel? newlyCreatedInfo =
            await infoRepository.createInfo(state.info);
        emit(InfoState(
          status: InfoStatus.created,
          info: newlyCreatedInfo,
        ));
      } catch (e) {
        emit(state.copyWith(status: InfoStatus.failure));
      }
    });

    on<InfoWelcomeClicked>((event, emit) async {
      emit(state.copyWith(
        status: InfoStatus.success,
      ));
    });

    on<InfoSignoutRequested>((event, emit) async {
      emit(InfoState(info: InfoModel(), status: InfoStatus.initial));
    });
  }
}
