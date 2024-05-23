import 'package:blog_app/core/secrets/supabse_secrets.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Supabase
    final supabase = await Supabase.initialize(
        url: SupabaseSecret.supabaseUrl,
        anonKey: SupabaseSecret.supabaseAnonKey);

    // final mongoDbClient = await MongoDbClient.connect();
    // print('mongodb connected succesfully');
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              userSignUp: UserSignUp(
                repository: AuthRepositoryImpl(
                  remoteDataSource: AuthRemoteDataSource(supabase.client),
                ),
              ),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    print(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SafeArea(child: SignUpPage()),
    );
  }
}
