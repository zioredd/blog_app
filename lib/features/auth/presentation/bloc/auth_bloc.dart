// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:bloc/bloc.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:meta/meta.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    print('AuthBloc: AuthSignUp event received');
    print('AuthBloc: AuthLoading state emitted');

    final res = await _userSignUp(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));

    res.fold(
      (l) {
        print('AuthBloc: AuthFailure state emitted with message: ${l.message}');
        emit(AuthFailure(message: l.message));
      },
      (r) => _emitAuthSuccess(r),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    print('AuthBloc: AuthLogin event received');

    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold(
      (l) {
        print('AuthBloc: AuthFailure state emitted with message: ${l.message}');
        emit(AuthFailure(message: l.message));
      },
      (r) => _emitAuthSuccess(r),
    );
  }

  void _onAuthCheck(AuthCheck event, Emitter<AuthState> emit) async {
    print('AuthBloc: AuthCheck event received');

    final res = await _currentUser(NoParams());

    res.fold(
      (l) {
        print('AuthBloc: AuthFailure state emitted with message: ${l.message}');
        emit(AuthFailure(message: l.message));
      },
      (r) => _emitAuthSuccess(r),
    );
  }

  void _emitAuthSuccess(User user) {
    _appUserCubit.updateUser(user);
    AuthSuccess(user: user);
    print('AuthBloc: AuthSuccess state emitted with user: $user');
  }

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthCheck>(_onAuthCheck);
  }
}
