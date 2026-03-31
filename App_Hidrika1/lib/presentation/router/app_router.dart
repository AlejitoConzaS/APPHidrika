import 'package:apphidrika1/presentation/screens/camera/camera_screen.dart';
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
      return RegisterScreen(email: data?['userName'] ?? '');
    },
  ),
  GoRoute(
    path: '/empresa',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/camera',
    name: CameraScreen.name,
    builder: (context, state) => const CameraScreen(),
    ) 
]);
