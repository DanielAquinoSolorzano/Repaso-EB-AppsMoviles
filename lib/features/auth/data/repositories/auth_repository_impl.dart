
import 'package:book_app/core/storage/token_storage.dart';
import 'package:book_app/features/auth/data/remote/auth_service.dart';
import 'package:book_app/features/auth/data/remote/login_response.dto.dart';
import 'package:book_app/features/auth/domain/auth_repository.dart';
import 'package:book_app/features/auth/domain/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;
  final TokenStorage tokenStorage;
  const AuthRepositoryImpl({required this.service, required this.tokenStorage});

  @override
  Future<User> login(String email, String password) async {
    final LoginResponseDto dto = await service.login(email, password);
    await tokenStorage.saveToken(dto.token);
    return dto.toDomain();
  }

}