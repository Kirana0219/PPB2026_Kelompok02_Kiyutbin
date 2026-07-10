import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraService extends ChangeNotifier {
  CameraController? _controller;
  final ImagePicker _picker = ImagePicker();

  bool _isInitialized = false;
  bool _isFlashOn = false;
  XFile? _capturedImage;

  CameraController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isFlashOn => _isFlashOn;
  XFile? get capturedImage => _capturedImage;

  /// ============================
  /// Initialize Camera
  /// ============================

  Future<void> initialize() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        debugPrint("Camera tidak ditemukan.");
        return;
      }

      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller!.initialize();

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint("Initialize Camera Error : $e");
    }
  }

  /// ============================
  /// Capture Image
  /// ============================

  Future<XFile?> takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return null;
    }

    try {
      final image = await _controller!.takePicture();

      _capturedImage = image;

      notifyListeners();

      return image;
    } catch (e) {
      debugPrint("Take Picture Error : $e");
      return null;
    }
  }

  /// ============================
  /// Gallery
  /// ============================

  Future<File?> pickFromGallery() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) return null;

      _capturedImage = image;

      notifyListeners();

      return File(image.path);
    } catch (e) {
      debugPrint("Gallery Error : $e");
      return null;
    }
  }

  /// ============================
  /// Toggle Flash
  /// ============================

  Future<void> toggleFlash() async {
    if (_controller == null) return;

    try {
      _isFlashOn = !_isFlashOn;

      await _controller!.setFlashMode(
        _isFlashOn
            ? FlashMode.torch
            : FlashMode.off,
      );

      notifyListeners();
    } catch (e) {
      debugPrint("Flash Error : $e");
    }
  }

  /// ============================
  /// Dispose
  /// ============================

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}