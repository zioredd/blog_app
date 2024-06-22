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

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;
  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    print('password: $password email: $email');

    try {
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      print('this is successssssssssssssssssssssssssssssssssssss');
      if (response.user == null) {
        print('user is nullllllllllllllllllllllllll');
        throw ServerException('User is null!');
      }
      print('the return $UserModel.fromJson(response.user!.toJson())');
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(name: currentUserSession!.user.userMetadata?['name']);
    } catch (e) {
      print('this is in the catch blockkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
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
        final userData = await supabaseClient
            .from("profiles")
            .select()
            .eq('id', currentUserSession!.user.id);

        return UserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
