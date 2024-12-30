
import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entity/user.dart';
import '../../../../core/constents/constants.dart';
import '../../../../core/error/custom_exception.dart';
import '../../../../core/network/connection_checker.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasources/auth_remote_data_sources.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ConnectionChecker connectionChecker;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.connectionChecker,);

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword({required email, required password}) async {
    try {
      if(!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword({required email, required password, required name}) async {
    try {
      if(!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final user = await authRemoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );
      return right(user);
    } on CustomException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async{
    try {
      if(!await (connectionChecker.isConnected)) {
        final session = authRemoteDataSource.currentSession;
        if(session == null) {
          return left(Failure("User is not Logged In"));
        }
        return right(UserModel(email: session.user.email ?? '', name: '', id: session.user.id));
      }
      final user = await authRemoteDataSource.getCurrentUserData();
      if(user == null) {
        return left(Failure("User is not Logged In"));
      } else {
        return right(user);
      }

    } on CustomException catch(e) {
      throw CustomException(e.message);
    }

  }

}