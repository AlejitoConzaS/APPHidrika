import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Expanded(child: Container(color: colors.primary)),
        Expanded(child: Container(color: colors.surface)),
      ],
    );
  }
}
