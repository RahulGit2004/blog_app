import 'package:blog_app/core/common/entity/user.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}
final class AppUserSignIn extends AppUserState {
  final User user;
  AppUserSignIn(this.user);
}
