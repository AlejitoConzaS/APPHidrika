import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class CustomInputFieldWidget extends StatelessWidget {
  final String value;
  final bool obscureText;
  final String hintText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomInputFieldWidget({
    super.key,
    required this.value,
    this.obscureText = false,
    required this.hintText,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.borderColor,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
