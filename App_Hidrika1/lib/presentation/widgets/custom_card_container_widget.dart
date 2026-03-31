import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class CustomCardContainerWidget extends StatelessWidget {
  final Widget child;
  final double verticalPadding;
  final double horizontalPadding;
  final double horizontalMargin;

  static const _defaultVerticalPadding = 16.0;
  static const _defaultHorizontalPadding = 24.0;
  static const _defaultHorizontalMargin = 40.0;

  const CustomCardContainerWidget({
    super.key,
    required this.child,
    this.verticalPadding = _defaultVerticalPadding,
    this.horizontalPadding = _defaultHorizontalPadding,
    this.horizontalMargin = _defaultHorizontalMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
