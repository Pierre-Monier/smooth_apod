import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ApodErrorVisualContent extends StatelessWidget {
  const ApodErrorVisualContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      // * this is to force the apod overlay info to show all it's content
      height: (screenHeight / 3) * 2,
      child: Center(
        child:
            Lottie.asset('assets/animation/error_lottie.json', repeat: false),
      ),
    );
  }
}
