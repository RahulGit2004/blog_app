import 'package:blog_app/core/error/custom_exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;

  Future<UserModel> signUpWithEmailPassword({
    required email,
    required password,
    required name,
  });

  Future<UserModel> signInWithEmailPassword({
    required email,
    required password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signInWithEmailPassword(
      {required email, required password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        throw CustomException("User is not Signed Successfully");
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentSession!.user.email);
    } on AuthException catch (e) {
      throw CustomException(e.message);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required email, required password, required name}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {'name': name});
      if (response.user == null) {
        throw CustomException("User is not Created Successfully");
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentSession!.user.email);
    } on AuthException catch (e) {
      throw CustomException(e.message);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: currentSession!.user.email);
      }
      return null;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
}
