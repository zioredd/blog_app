import 'package:blog_app/core/errors/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  AuthRepository repository;
  CurrentUser({
    required this.repository,
  });

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.currentUser();
  }
}