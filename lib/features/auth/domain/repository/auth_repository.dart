import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/common/entity/user.dart';
abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailAndPassword({
    required email,
    required password,
    required name,
});

  Future<Either<Failure, User>> signInWithEmailAndPassword({
    required email,
    required password,
  });

  Future<Either<Failure, User>> currentUser();
}