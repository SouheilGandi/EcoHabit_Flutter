import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthService{

  final String baseUrl = "http://192.168.186.1:3000";

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/user/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final body=json.decode(response.body);
      final token =body['token'];
      print('Token: $token');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signup(String name,String lastName,int matricule,String email,String password) async {
    final url = Uri.parse('$baseUrl/user/signup');
    final response = await http.post(
      url,
      headers: {
        'Content-Type':'application/json',
      },
      body: jsonEncode({
        'name':name,
        'lastName':lastName,
        'matricule':matricule,
        'email':email,
        'password':password,
      }),
    );
    if (response.statusCode==201){
      final body=json.decode(response.body);
      final token =body['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);
      return true;
    }else{
      return false;
    }
  }

Future<String?> getToken() async{
  final prefs = await   SharedPreferences.getInstance();
  return prefs.getString('authToken');
}

  Future<void> printToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    print('Retrieved token: $token');
  }
Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('authToken'); // Clear the auth token
  print('User logged out');
}

}