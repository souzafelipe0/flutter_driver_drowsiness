import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver_drowsiness/components/warning_blinking_icon.dart';
import 'package:flutter_driver_drowsiness/screens/face_detector_view.dart';
import '../components/reusable_primary_button.dart';
import '../../constants/text_style.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => AlertScreenState();
}

class AlertScreenState extends State<AlertScreen> {
  late Future<bool> futureCamera;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playAlertSound();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> playAlertSound() async {
    await player.play(AssetSource("sounds/red-alert.wav"));
    player.onPlayerComplete.listen((event) {
      player.play(AssetSource("sounds/red-alert.wav"));
    });
  }

  Future<void> stopAlertSound() async {
    player.stop();
  }

  Future<void> stopAlert(context) async {
    await stopAlertSound();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FaceDetectorView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/warning-image-4.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          const Positioned(
            top: 120,
            left: 130,
            child: WarningBlinkIcon(),
          ),
          Positioned(
            bottom: 200,
            left: 30,
            child: Text(
              'BE CAREFUL',
              style: kTitleTextStyle.copyWith(color: Colors.white, fontSize: 40),
            ),
          ),
          Positioned(
            bottom: 170,
            left: 30,
            child: Text(
              'It looks like you are tired',
              style: kSubtitleTextStyle.copyWith(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.start,
            ),
          ),
          Positioned(
            bottom: 120,
            left: 30,
            child: Text(
              'take a break!',
              style: kSubtitleTextStyle.copyWith(color: Colors.white, fontSize: 37),
              textAlign: TextAlign.start,
            ),
          ),
          Positioned(
            bottom: 70,
            left: 30,
            right: 200,
            child: ReusablePrimaryButton(
              childText: 'STOP ALERT',
              buttonColor: Colors.white,
              childTextColor: Colors.black,
              onPressed: () {
                stopAlert(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
