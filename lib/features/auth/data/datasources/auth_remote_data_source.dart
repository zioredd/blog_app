import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  // final Db mongoDb;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) {
    // Add your implementation here
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required name, required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {'name': name});
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<UserModel> signUpWithEmailPassword({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final newUser = {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //     };
  //     final users = mongoDb.collection('users');
  //     final existingUser = await users.findOne({'email': email});
  //     if (existingUser != null) {
  //       throw ServerException('User already exists');
  //     }
  //     mongoDb.collection('users').insertOne(newUser);
  //     print('user inserted to database');
  //     return UserModel.fromJson(newUser);
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }
}
