abstract class Failure {
  Failure(this.message);

  final String message;
}

class TaskFailure extends Failure {
  TaskFailure(super.message);
}
