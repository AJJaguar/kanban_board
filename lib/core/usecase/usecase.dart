import 'package:dartz/dartz.dart';
import 'package:innoscripta_task/core/error/failure.dart';

mixin UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

class NoParams {}
