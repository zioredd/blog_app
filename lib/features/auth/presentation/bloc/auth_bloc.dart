// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  // final AuthModel authModel = AuthModel(name: name, email: email, password: password);
  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      final res = await _userSignUp(UserSignUpParams(
          email: event.email, name: event.name, password: event.passport));

      res.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => emit(AuthSuccess(userId: r)));
    });
  }
}
