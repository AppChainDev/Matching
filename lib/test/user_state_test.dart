import 'package:flutter_test/flutter_test.dart';
import 'package:rinlin/services/userapi_service.dart';
import 'package:rinlin/state/user_state.dart';
import 'package:rinlin/models/user_model.dart';

void main() {
  test('User login and logout', () {
    final userState = UserState(userApiService: UserApiService(baseUrl: 'https://api.example.com'));
    // final user = UserModel(id: '1', name: 'John Doe', email: 'john.doe@example.com');

    expect(userState.isAuthenticated, false);

    // userState.login('email', 'password');
    expect(userState.isAuthenticated, true);
    // expect(userState.user, user);

    userState.logout();
    expect(userState.isAuthenticated, false);
    expect(userState.user, null);
  });
}
