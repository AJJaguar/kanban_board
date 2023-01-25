part of 'localization_bloc.dart';

abstract class LocalizationEvent {
  const LocalizationEvent();
}

class ChangeLocalizationEvent extends LocalizationEvent {
  const ChangeLocalizationEvent(this.selectedLocal);
  final String selectedLocal;
}
