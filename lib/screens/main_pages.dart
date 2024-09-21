import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_driver_drowsiness/screens/face_detector_view.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class MainPages extends StatelessWidget {
  const MainPages({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WithPages(),
    );
  }
}

class WithPages extends StatefulWidget {
  static const style = TextStyle(
    fontSize: 30,
    fontFamily: "Billy",
    fontWeight: FontWeight.w600,
  );

  const WithPages({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WithPages createState() => _WithPages();
}

class _WithPages extends State<WithPages> {
  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            LiquidSwipe(
              pages: [
                Container(
                  color: Colors.lightGreen,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.all(60.0), child: Image.asset('assets/images/sleepy-driver.png', height: 300, fit: BoxFit.contain)),
                      const Column(
                        children: <Widget>[
                          Text(
                            "Welcome to",
                            style: WithPages.style,
                          ),
                          Text(
                            "Driver drowsiness",
                            style: WithPages.style,
                          ),
                          Text(
                            "detection App",
                            style: WithPages.style,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.lime,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.all(60.0), child: Image.asset('assets/images/sleepy-driver2.png', height: 300, fit: BoxFit.contain)),
                      const Column(
                        children: <Widget>[
                          Text(
                            "avoid sleeping ",
                            style: WithPages.style,
                          ),
                          Text(
                            "at the ",
                            style: WithPages.style,
                          ),
                          Text(
                            "wheel",
                            style: WithPages.style,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.all(60.0), child: Image.asset('assets/images/user-faceid.png', height: 300, fit: BoxFit.contain)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FaceDetectorView()),
                            );
                          },
                          child: const Text("CLICK HERE TO START"),
                        ),
                      ),
                      const Column(
                        children: <Widget>[
                          Text(
                            "Lets start",
                            style: WithPages.style,
                          ),
                          Text(
                            "YOUR face",
                            style: WithPages.style,
                          ),
                          Text(
                            "validation",
                            style: WithPages.style,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
              positionSlideIcon: 0.8,
              fullTransitionValue: 880,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              preferDragFromRevealedArea: true,
              enableSideReveal: true,
              ignoreUserGestureWhileAnimating: true,
              enableLoop: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(3, _buildDot),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int page = 0;
  late LiquidController liquidController;
  late UpdateType updateType;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return SizedBox(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: SizedBox(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }
}
