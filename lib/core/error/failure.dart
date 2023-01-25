import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;
}

class TaskFailure extends Failure {
  const TaskFailure(super.message);
  
  @override
  List<Object?> get props => [super.message];
}
