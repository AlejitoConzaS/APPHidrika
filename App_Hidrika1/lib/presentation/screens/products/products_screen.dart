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
        title: const Text('Mis Productos'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarWidget(),
            SizedBox(height: 16),
            CustomTextWidget(text: "Bienvenido Cliente", textType: TextType.title)
          ],
        ),
      ),
    );
  }
}
