// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:bloc/bloc.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:meta/meta.dart';

import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      print('AuthBloc: AuthSignUp event received');
      emit(AuthLoading());
      print('AuthBloc: AuthLoading state emitted');

      final res = await _userSignUp(UserSignUpParams(
          email: event.email, name: event.name, password: event.password));

      res.fold(
        (l) {
          print(
              'AuthBloc: AuthFailure state emitted with message: ${l.message}');
          emit(AuthFailure(message: l.message));
        },
        (r) {
          print('AuthBloc: AuthSuccess state emitted with user: $r');
          emit(AuthSuccess(user: r));
        },
      );
    });
  }
}
