import 'package:flutter/material.dart';

class CountdownOverlay extends StatelessWidget {
  const CountdownOverlay({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Text(
            text,
            // A different key tells AnimatedSwitcher "this is a new widget",
            // so it plays the transition each time the number changes.
            key: ValueKey<String>(text),
            style: const TextStyle(
              fontSize: 120,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
