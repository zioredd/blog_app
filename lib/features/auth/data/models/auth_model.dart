// abstract interface class AuthModel {
//   Future<String> signUpWithEmailPassword(
//       {required String name, required String email, required String password});

//   Future<String> loginWithEmailPassword(
//       {required String email, required String password});
// }

class AuthModel {
  final String name;
  final String email;
  final String password;

  AuthModel({
    required this.name,
    required this.email,
    required this.password,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
