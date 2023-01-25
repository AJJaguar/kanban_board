import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState()) {
    on<ChangeLocalizationEvent>(_onChangeLocalizationEvent);
  }

  FutureOr<void> _onChangeLocalizationEvent(
    ChangeLocalizationEvent event,
    Emitter<LocalizationState> emit,
  ) {
    emit(
      LocalizationState(
        selectedLocal: event.selectedLocal,
      ),
    );
  }
}
