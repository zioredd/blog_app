// ignore_for_file: avoid_print

import 'package:blog_app/core/errors/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  // final Db mongoDb;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      if (response.user == null) {
        throw ServerException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(name: currentUserSession!.user.userMetadata?['name']);
    } catch (e) {
      throw ServerException(e.toString());
    }
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

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        print('currentUserSession: ${currentUserSession!.user.id}');
      } else {
        print('currentUserSession is null');
      }
      final userData = await supabaseClient
          .from("profiles")
          .select()
          .eq('id', currentUserSession!.user.id);

      return UserModel.fromJson(userData.first)
          .copyWith(email: currentUserSession!.user.email);
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
