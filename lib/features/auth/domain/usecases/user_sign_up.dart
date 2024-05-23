// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  AuthRepository repository;
  UserSignUp({
    required this.repository,
  });
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    return await repository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
