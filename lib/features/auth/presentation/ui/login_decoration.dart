import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';

class LoginDecoration extends StatelessWidget {
  const LoginDecoration({required this.height, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Blob.random(
                styles: BlobStyles(
                  color: Theme.of(context).primaryColor,
                ),
                size: 400,
              ),
            ),
            Image.asset('assets/img/logo.png'),
          ],
        ),
      ),
    );
  }
}
