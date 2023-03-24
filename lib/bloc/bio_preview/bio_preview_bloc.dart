import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../base_bloc.dart';
import 'bio_preview_event.dart';
import 'bio_preview_state.dart';

class BioPreviewBloc extends BaseBloc<BioPreviewEvent, BioPreviewState> {
  BioPreviewBloc() : super(const BioPreviewState(items: [])) {
    on<LoadingBioDataEvent>(_loadBioData);
  }

  FutureOr<void> _loadBioData(
      LoadingBioDataEvent event, Emitter<BioPreviewState> emit) {
    emit.call(state.copyWith(items: event.items));
  }
}
