import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraViewModel extends ChangeNotifier {
  CameraController? _controller;
  bool _isInitialized = false;
  XFile? _capturedImage;

  CameraController? get cameraController => _controller;
  bool get isInitialized => _isInitialized;
  XFile? get capturedImage => _capturedImage;

  CameraViewModel() {
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      backCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print("Error inicializando cámara: $e");
    }
  }

  Future<void> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      _capturedImage = await _controller!.takePicture();
      notifyListeners();
    } catch (e) {
      print("Error al tomar foto: $e");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
