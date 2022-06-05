import 'package:flutter/material.dart';

class ApodLoaderVisualContent extends StatelessWidget {
  const ApodLoaderVisualContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
