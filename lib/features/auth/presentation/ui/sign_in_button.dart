import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';
import '../../../../util/app_spacing.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.icon,
    required this.text,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(AppSpacing.p32),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.p32),
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.p16),
            child: Row(
              children: [
                AppSpacing.gapW16,
                icon,
                AppSpacing.gapW16,
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
