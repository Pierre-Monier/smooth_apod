import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';

class LoginDecoration extends StatelessWidget {
  const LoginDecoration({required this.height, Key? key}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColor.main,
      child: const Text('todo'),
    );
  }
}
