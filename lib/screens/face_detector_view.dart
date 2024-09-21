import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver_drowsiness/screens/alert_screen.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'detector_view.dart';
import 'face_detector_painter.dart';

class FaceDetectorView extends StatefulWidget {
  const FaceDetectorView({super.key});

  @override
  State<FaceDetectorView> createState() => _FaceDetectorViewState();
}

class _FaceDetectorViewState extends State<FaceDetectorView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableContours: true,
      enableLandmarks: true,
    ),
  );

  int _countFacesEyeClosed = 0;
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.front;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      title: 'Driver Drowsiness Detection',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      bool isEyeOppened = await isEyeOppenedValidation(faces);

      if (!isEyeOppened) {
        _countFacesEyeClosed++;
      } else {
        _countFacesEyeClosed = 0;
      }
    }

    if (_countFacesEyeClosed >= 4) {
      showAlertScreen();
      return;
    }

    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<bool> isEyeOppenedValidation(List<Face> faces) async {
    bool eyesOppened = true;

    for (Face face in faces) {
      double leftEyeOpenProbability = face.leftEyeOpenProbability ?? -1.0;
      double rightEyeOpenProbability = face.rightEyeOpenProbability ?? -1.0;

      if (leftEyeOpenProbability <= 0.6 || rightEyeOpenProbability <= 0.6) {
        eyesOppened = false;
      } else {
        eyesOppened = true;
        return eyesOppened;
      }
    }

    return eyesOppened;
  }

  showAlertScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AlertScreen()),
    );
  }
}
