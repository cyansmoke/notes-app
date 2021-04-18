import 'package:notes/api/user/user_client.dart';
import 'package:notes/model/user.dart';

class UserRepository {
  UserRepository(this._apiClient);

  final UserApiClient _apiClient;

  String get token => _token;
  String _token;

  Future<String> signInUser(String login, String password) async {
    final userToSignIn = User(login, password);
    return _authUser(userToSignIn);
  }

  Future<String> signUpUser(String login, String password, String email) async {
    final userToSignUp = User(login, password, email);
    return _authUser(userToSignUp);
  }

  Future<String> _authUser(User user) async {
    final newToken = await _apiClient.signIn(user);
    _token = newToken.token;
    return _token;
  }
}
