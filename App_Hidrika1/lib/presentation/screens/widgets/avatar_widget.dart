import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final double iconSize;

  static const _defaultIconSize = 200.0;

  const AvatarWidget({
    super.key,
    this.iconSize = _defaultIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
          'assets/images/logohidrika.png',
          width: iconSize,
          fit: BoxFit.contain,
    );
  }
}
