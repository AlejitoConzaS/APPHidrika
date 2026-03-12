import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback? onPressed;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.type,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: type.backgroundColor,
        side: BorderSide(
          color: type.borderColor,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: type.textColor,
          fontSize: 14,
        ),
      ),
    );
  }
}

enum ButtonType {
  primary(
    backgroundColor: AppColors.primaryColor,
    borderColor: Colors.transparent,
    textColor: AppColors.whiteColor,
  ),
  secondary(
    backgroundColor: AppColors.whiteColor,
    borderColor: AppColors.primaryColor,
    textColor: AppColors.primaryColor,
  );

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const ButtonType({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });
}
