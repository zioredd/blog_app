import 'package:blog_app/core/errors/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabaseCllient;
  // final Db mongoDb;
  // final AuthModel authModel;

  AuthRemoteDataSource(this.supabaseCllient);
  Future<String> loginWithEmailPassword(
      {required String email, required String password}) {
    throw UnimplementedError();
  }

  Future<String> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseCllient.auth
          .signUp(password: password, email: email, data: {'name': name});
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      print(response.user);
      return response.user!.id;
    } catch (e) {
      ServerException(e.toString());
    }
    throw UnimplementedError();
  }

  // Future<AuthModel> signUpWithEmailPassword({
  //   required String name,
  //   required String email,
  //   required String password,
  // }) async {
  //   print(name);
  //   try {
  //     final users = mongoDb.collection('users');
  //     final existingUser = await users.findOne({'email': email});
  //     if (existingUser != null) {
  //       throw ServerException('User already exists');
  //     }

  //     final newUser = {
  //       'name': name,
  //       'email': email,
  //       'password': password,
  //     };
  //     final result = await users.insertOne(authModel.fromJson(Map(name: name, )));
  //     print(result);
  //     return result;
  //   } catch (e) {
  //     print('this is catch block. the error is $e');
  //     throw ServerException(e.toString());
  //   }
  // }
}
