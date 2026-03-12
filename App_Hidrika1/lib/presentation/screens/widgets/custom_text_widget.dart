import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextType textType;

  const CustomTextWidget({
    super.key,
    required this.text,
    required this.textType,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: textType.fontSize,
        fontWeight: textType.fontWeight,
        color: textType.color,
      ),
    );
  }
}

enum TextType {
  title(
    fontSize: 32.0,
    fontWeight: FontWeight.w800,
    color: AppColors.headlineColor,
  ),
  subtitle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.headlineColor,
  );

  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const TextType({
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  });
}
