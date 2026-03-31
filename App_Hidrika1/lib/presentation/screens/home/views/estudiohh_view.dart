import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../resources/resources.dart';
import '../../../view_models/view_models.dart';
import '../../../widgets/widgets.dart';
import 'estudiohh_item_view.dart';
import '../../screens.dart';


class EstudiohhView extends StatefulWidget {
  const EstudiohhView({super.key});

  @override
  State<EstudiohhView> createState() => _EstudiohhViewState();
}

class _EstudiohhViewState extends State<EstudiohhView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final estudiohhViewModel = context.read<EstudiohhViewModel>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!estudiohhViewModel.isLoading && estudiohhViewModel.pageToken != null) {
        estudiohhViewModel.fetchEstudiohh();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final estudiohhViewModel = context.watch<EstudiohhViewModel>();
    final estudiohh = estudiohhViewModel.estudiohh;

    if (estudiohhViewModel.isLoading && estudiohh.isEmpty) {
      return _buildLoading(context);
    }
    if (estudiohhViewModel.errorMessage != null && estudiohh.isEmpty) {
      return _buildError(context, estudiohhViewModel);
    }
    if (estudiohh.isEmpty) return _buildEmpty(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: estudiohhViewModel.pageToken != null
            ? estudiohh.length + 1
            : estudiohh.length,
        itemBuilder: (context, index) {
          if (index < estudiohh.length) {
            return EstudiohhItemView(estudiohh: estudiohh[index]);
          } else {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          CustomTextWidget(
            text: 'Cargando estudiohh...',
            textType: TextType.title,
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, EstudiohhViewModel viewModel) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: AppColors.errorColor,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.errorColor),
          ),
          CustomButtonWidget(
            text: 'Reintentar',
            type: ButtonType.secondary,
            onPressed: () => viewModel.fetchEstudiohh(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return const Center(
      child: Text(
        'No hay productos disponibles.\n¡Agrega uno nuevo!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}


