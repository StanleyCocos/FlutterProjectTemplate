import '../../../core/constants/api_constants.dart';
import '../../../core/domain/datasources/http_client.dart';
import '../../../core/domain/datasources/network_interceptor.dart';
import 'auth_remote_datasource.dart';

/// 认证远程数据源实现（使用网络中间层）
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._httpClient);

  final HttpClient _httpClient;

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _httpClient.post<Map<String, dynamic>>(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.isSuccess) {
        return response.data;
      } else {
        throw NetworkException(
          message: response.message ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException(
        message: 'Login failed: ${e.toString()}',
        original: e,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String? name,
  ) async {
    try {
      final response = await _httpClient.post<Map<String, dynamic>>(
        ApiConstants.register,
        data: {
          'email': email,
          'password': password,
          ...?name != null ? {'name': name} : null,
        },
      );

      if (response.isSuccess) {
        return response.data;
      } else {
        throw NetworkException(
          message: response.message ?? 'Registration failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is NetworkException) rethrow;
      throw NetworkException(
        message: 'Registration failed: ${e.toString()}',
        original: e,
      );
    }
  }
}
