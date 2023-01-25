import 'package:equatable/equatable.dart';

class AddTaskParam extends Equatable {
  const AddTaskParam({required this.title, required this.description});
  final String title;
  final String description;

  Map<String, dynamic> toJson() => {
        'name': title,
        'description': description,
      };

  @override
  List<Object?> get props => [
        title,
        description,
      ];
}
