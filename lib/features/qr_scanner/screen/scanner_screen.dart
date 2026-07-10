import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../core/layout/widgets/app_header.dart';
import '../../../core/theme/app_colors.dart';
import '../services/camera_service.dart';
import '../widgets/camera_buttons.dart';
import '../widgets/scanner_overlay.dart';
import '../../../core/routes/app_router.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final CameraService _cameraService = CameraService();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _cameraService.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppHeader(
        showBackButton: true,
        profileImage: null,
        onNotification: () {},
        onProfile: () {
          Navigator.pushNamed(context, AppRouter.profile);
        },
      ),

      body: SafeArea(
        top: false,
        child: _cameraService.isInitialized
            ? Stack(
                fit: StackFit.expand,
                children: [

                  /// ======================
                  /// CAMERA PREVIEW
                  /// ======================
                  ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.center,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _cameraService.controller!.value.previewSize!.height,
                          height: _cameraService.controller!.value.previewSize!.width,
                          child: CameraPreview(
                            _cameraService.controller!,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// ======================
                  /// OVERLAY
                  /// ======================

                  const ScannerOverlay(),

                  /// ======================
                  /// BOTTOM BUTTON
                  /// ======================

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 32,
                        left: 24,
                        right: 24,
                      ),
                      child: CameraButtons(
                        flashOn: _cameraService.isFlashOn,

                        onGallery: () async {
                          await _cameraService.pickFromGallery();
                        },

                        onCapture: () async {
                          await _cameraService.takePicture();
                        },

                        onFlash: () async {
                          await _cameraService.toggleFlash();

                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
      ),
    );
  }
}