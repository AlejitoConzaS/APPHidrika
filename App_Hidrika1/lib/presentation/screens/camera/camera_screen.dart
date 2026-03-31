import 'package:apphidrika1/presentation/view_models/camera_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../view_models/view_models.dart';

class CameraScreen extends StatelessWidget {
  static var name = 'camera_screen';

  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CameraViewModel(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Consumer<CameraViewModel>(
            builder: (context, vm, child) {
              if (!vm.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vm.capturedImage != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.pop(vm.capturedImage!.path);
                });
              }

              return Stack(
                children: [
                  Center(
                    child: CameraPreview(vm.cameraController!),
                  ),
                  _buildBottomBar(context, vm),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, CameraViewModel vm) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          color: Colors.black54,
        ),
        child: Center(
          child: IconButton(
            onPressed: vm.takePicture,
            iconSize: 70,
            icon: const Icon(Icons.radio_button_checked, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
