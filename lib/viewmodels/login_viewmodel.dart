import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class LoginViewModel extends ChangeNotifier{

final AuthService _authService=AuthService();
String _email='';
String _password='';

String get email => _email;
String get password => _password;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<bool> login() async{
    return await _authService.login(_email, _password);
  }
}