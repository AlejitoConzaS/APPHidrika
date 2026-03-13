import 'package:carrito_compras/presentation/screens/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  static var name = 'products_screen';

  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Huella de agua'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AvatarWidget(),
            const SizedBox(height: 16),
            const CustomTextWidget(text: "Bienvenido Cliente", textType: TextType.title),
            const SizedBox(height: 32),
            CustomButtonWidget(
            text: 'Subir información',
            type: ButtonType.primary,
            onPressed: () {
             print('Hola');
            },
            ),
            const SizedBox(height: 32),
            CustomButtonWidget(
            text: 'Requerimientos pendientes',
            type: ButtonType.primary,
            onPressed: () {
             print('Hola');
            },
            ),
             const SizedBox(height: 32),
            CustomButtonWidget(
            text: 'Historial de estudios',
            type: ButtonType.primary,
            onPressed: () {
             print('Hola');
            },
            ),
             const SizedBox(height: 32),
            CustomButtonWidget(
            text: 'Comparar estudios por año',
            type: ButtonType.primary,
            onPressed: () {
             print('Hola');
            },
            ),
             const SizedBox(height: 32),
            CustomButtonWidget(
            text: 'Indicadores clave',
            type: ButtonType.primary,
            onPressed: () {
             print('Hola');
            },
            ),
          ],
        ),
      ),
    );
  }
}