import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  AuthRepository repository;
  UserLogin({
    required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    var result = await repository.loginWithEmailPassword(
        email: params.email, password: params.password);
    return result;
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
