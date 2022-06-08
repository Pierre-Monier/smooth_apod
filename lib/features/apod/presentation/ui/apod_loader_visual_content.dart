import 'package:flutter/material.dart';

class ApodLoaderVisualContent extends StatelessWidget {
  const ApodLoaderVisualContent({this.value, super.key});

  final double? value;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      child: Center(
        child: CircularProgressIndicator(
          value: value,
        ),
      ),
    );
  }
}
