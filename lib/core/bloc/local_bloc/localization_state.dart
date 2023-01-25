part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  const LocalizationState({this.selectedLocal = 'en'});
  final String selectedLocal;
  
  @override
  List<Object?> get props => [selectedLocal];
}
