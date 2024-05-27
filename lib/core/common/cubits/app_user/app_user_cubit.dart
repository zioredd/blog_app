// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:equatable/equatable.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    if (user == null) {
      print('AppCubit: user is null');
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
