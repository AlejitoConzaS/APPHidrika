import 'package:go_router/go_router.dart';

import '../screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: LoginScreen.name,
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    // path: '/register/:userName',
    path: '/register',
    name: RegisterScreen.name,
    builder: (context, state) {
      // final user = state.pathParameters['userName'];

      final data = state.extra as Map<String, dynamic>?;
      return RegisterScreen(userName: data?['userName'] ?? '');
    },
  ),
  GoRoute(
    path: '/products',
    name: ProductsScreen.name,
    builder: (context, state) => const ProductsScreen(),
  ),
]);
