import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entity/user.dart';

class UserSignIn implements UseCase<User, UserSignInPrams> {
  final AuthRepository authRepository;

  UserSignIn(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInPrams prams) async {
    return await authRepository.signInWithEmailAndPassword(
        email: prams.email, password: prams.password);
  }
}

class UserSignInPrams {
  String email;
  String password;

  UserSignInPrams({required this.email, required this.password});
}
