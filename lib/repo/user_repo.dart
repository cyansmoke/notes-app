import 'package:notes/api/user/user_client.dart';
import 'package:notes/model/token.dart';
import 'package:notes/model/user.dart';

class UserRepository {
  UserRepository(this._apiClient);

  final UserApiClient _apiClient;

  String get token => 'Bearer $_token';
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
    Token newToken;
    if (user.email == null) {
      newToken = await _apiClient.signIn(user);
    } else {
      newToken = await _apiClient.signUp(user);
    }
    _token = newToken.token;
    return _token;
  }
}
