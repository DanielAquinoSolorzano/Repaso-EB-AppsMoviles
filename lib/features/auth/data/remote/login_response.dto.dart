import 'package:book_app/features/auth/domain/user.dart';

class LoginResponseDto {
  final String token;
  final String lastName;
  final String firstName;
  final String email;

  const LoginResponseDto({
    required this.token,
    required this.lastName,
    required this.firstName,
    required this.email,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) {
    return LoginResponseDto(
      token: json['token'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      email: json['email'],
    );
  }

  User toDomain() {
    return User(lastName: lastName, firstName: firstName, email: email);
  }
}