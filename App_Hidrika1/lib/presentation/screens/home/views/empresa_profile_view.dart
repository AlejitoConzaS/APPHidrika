import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_models/view_models.dart';
import '../../../widgets/widgets.dart';

class EmpresaProfileView extends StatefulWidget {
  const EmpresaProfileView({super.key});

  @override
  State<EmpresaProfileView> createState() => _EmpresaProfileViewState();
}

class _EmpresaProfileViewState extends State<EmpresaProfileView> {
  late TextEditingController _nombreController;
  late TextEditingController _rubroController;

  @override
  void initState() {
    super.initState();
    final empresa = context.read<EmpresaViewModel>().currentEmpresa;
    _nombreController = TextEditingController(text: empresa?.nombre ?? '');
    _rubroController = TextEditingController(text: empresa?.rubro ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _rubroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final empresaViewModel = context.watch<EmpresaViewModel>();
    final empresa = empresaViewModel.currentEmpresa;

    if (empresa == null) return const Center(child: Text("No hay empresa"));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
                labelText: 'Nombre', border: OutlineInputBorder()),
            controller: TextEditingController(text: empresa.nombre),
            enabled: false, // No se puede editar
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _nombreController,
            decoration: const InputDecoration(
                labelText: 'Nombre', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _rubroController,
            decoration: const InputDecoration(
                labelText: 'Rubro', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: CustomButtonWidget(
              text: 'Guardar Cambios',
              type: ButtonType.primary,
              onPressed: empresaViewModel.isLoading
                  ? null
                  : () => _updateProfile(context),
            ),
          ),
        ],
      ),
    );
  }

  void _updateProfile(BuildContext context) {
    context.read<EmpresaViewModel>().updateEmpresa(
          _nombreController.text,
          _rubroController.text,
        );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil actualizado correctamente')),
    );
  }
}
