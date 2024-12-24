import 'package:flutter/material.dart';
import 'custom_textfield_black.dart';

Widget buildTextField({
required String label,
required TextEditingController controller,
required String? Function(String) validator,
bool obscureText = false,
}) {

  return ValueListenableBuilder(
    valueListenable: controller,
    builder: (context, _, __) {
      final errorText = validator(controller.text);
      return CustomTextFieldBlack(
        label: label,
        controller: controller,
        obscureText: obscureText,
        errorText: errorText,
      );
    },
  );
}