import 'package:flutter/material.dart';

class CustomTextFieldBlack extends StatelessWidget{
   final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;

  const CustomTextFieldBlack({super.key,
  required this.label,
  required this.controller,
  this.obscureText=false,
  this.errorText
  });
 
@override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
        errorText: errorText,
      ),
      style: const TextStyle(color: Colors.black),
      obscureText: obscureText,
    );
  }
  
  
}