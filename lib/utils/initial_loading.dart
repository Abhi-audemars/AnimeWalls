import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InitialLoader extends StatefulWidget {
  const InitialLoader({super.key});

  @override
  State<InitialLoader> createState() => _InitialLoaderState();
}

class _InitialLoaderState extends State<InitialLoader> {
  String delayedText = "";
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _updateTextAfterDelay();
  }

  void _updateTextAfterDelay() {
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        opacity = 1.0;
        delayedText = "...it may usually take 10-20 seconds!";
      });
    });

    Future.delayed(const Duration(seconds: 20), () {
      setState(() {
        opacity = 1.0;
        delayedText =
            "Seems like the server is slow at the moment, try restarting the app(clear from the background also)";
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _updateTextAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Lottie.asset('assets/load.json'),
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(seconds: 2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                delayedText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Colors.white60),
              ),
            ),
          )
        ],
      ),
    );
  }
}
