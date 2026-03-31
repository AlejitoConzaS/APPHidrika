import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/repositories.dart';
import 'domain/usecase/usecase.dart';
import 'presentation/router/app_router.dart';
import 'presentation/view_models/view_models.dart';
import 'resources/resources.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    print("Error al inicializar Firebase: $e");
  }

  final httpClient = http.Client();
  final estudiohhRepository = EstudiohhRepositoryImpl(httpClient);
  final getEstudiohhUseCase = DefaultGetEstudioUsecase(estudiohhRepository);
  final empresaRepositoryImpl = EmpresaRepositoryImpl(httpClient);
  final getEmpresaUsecase = DefaultGetEmpresaUsecase (empresaRepositoryImpl);
  final updateEmpresaUseCase = DefaultUpdateEmpresaUseCase(empresaRepositoryImpl);
  final authenticateEmpresaUsecase =
      DefaultAuthenticateEmpresaUsecase(empresaRepositoryImpl);
  final logoutEmpresaUsecase = DefaultLogoutEmpresaUsecase(empresaRepositoryImpl);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EmpresaViewModel(
            getEmpresaUsecase,
            updateEmpresaUseCase,
            authenticateEmpresaUsecase,
            logoutEmpresaUsecase,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => EstudiohhViewModel(getEstudiohhUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
