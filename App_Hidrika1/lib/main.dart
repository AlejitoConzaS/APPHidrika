import 'package:flutter/material.dart';

import 'presentation/router/app_router.dart';
import 'resources/resources.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: appRouter,
      theme: ColorTheme.fetchColorScheme(),
      darkTheme: ColorTheme.fetchDarkColorScheme(),
    );
  }
}
