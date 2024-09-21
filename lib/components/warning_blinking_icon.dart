import 'package:flutter/material.dart';

class WarningBlinkIcon extends StatefulWidget {
  const WarningBlinkIcon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BlinkIconState createState() => _BlinkIconState();
}

class _BlinkIconState extends State<WarningBlinkIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _colorAnimation = ColorTween(begin: Colors.orange, end: Colors.yellow).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
      setState(() {});
    });
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Icon(Icons.warning, size: 150, color: _colorAnimation.value);
      },
    );
  }
}
