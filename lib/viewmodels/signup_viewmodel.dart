import 'package:flutter/material.dart';
import 'package:timesheet/services/auth_service.dart';

class SignupViewModel extends ChangeNotifier{
  final AuthService _authService=AuthService();
  String _name='';
  String _lastName='';
  int _matricule=0;
  String _password='';
  String _email='';

  String get name=>_name;
  String get lastName=>_lastName;
  int get matricule => _matricule;
  String get email=>_email;
  String get password =>_password;

    set name(String value) {
    _name = value;
    notifyListeners();
  }
    set lastName(String value) {
    _lastName = value;
    notifyListeners();
  }
    set matricule(int value) {
    _matricule = value;
    notifyListeners();
  }
    set email(String value) {
    _email = value;
    notifyListeners();
  }
    set password(String value) {
    _password = value;
    notifyListeners();
  }

  Future<bool> signup() async {
    return await _authService.signup(_name, _lastName, _matricule, _email, _password);
  }

  String? validateName(String value){
    if (value.isEmpty) return 'Name cannot be empty';
    return null;
  }

    String? validateLastName(String value){
    if (value.isEmpty) return 'Last Name cannot be empty';
    return null;
  }

  String? validateMatricule(String value){
    if(value.isEmpty) return 'Matricule cannot be empty';
    final isNumeric = RegExp(r'^\d+$').hasMatch(value);
    if (!isNumeric) return 'Matricule must be a number';   
    if (value.length < 4) return 'Matricule must be at least 4 digits';
    return null;
  }
  
    String? validateEmail(String value) {
    final trimmedEmail = value.trim().toLowerCase();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(trimmedEmail)) return 'Invalid email address';
    return null;
  }

    String? validatePassword(String value) {
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Password must contain at least one number';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) return 'Password must contain at least one special character';
    return null;
  }

    String? validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }

  

}