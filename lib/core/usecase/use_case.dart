import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType, Parameters> {
  Future<Either<Failure, SuccessType>> call(Parameters parameters);
}

class NoPrams {}
