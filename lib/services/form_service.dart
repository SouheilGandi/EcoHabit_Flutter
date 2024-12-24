import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FormService{
  final String apiUrl='http://192.168.186.1:3000';

  Future<bool> submitForm(Map<String,dynamic> formData) async{
    try{
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      if (token == null){
        print('Error: No token found');
        return false;
      }

      print('Using token: $token');

     final response = await http.post(
        Uri.parse('$apiUrl/form/addForm'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':'Bearer $token',
        },
        body: jsonEncode(formData),
      );

      if (response.statusCode == 201) {
        return true;
      }else if (response.statusCode == 401){
        print('Error: Unauthorized, please log in again');
        // Handle re-login logic here
        return false;
      } else {
        return false;
      }
    }catch(error){
      print('Error submitting form: $error');
      return false;
    }
  }
}