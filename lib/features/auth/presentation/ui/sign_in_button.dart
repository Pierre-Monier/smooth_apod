import 'package:flutter/material.dart';

import '../../../../util/app_color.dart';
import '../../../../util/app_spacing.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.icon,
    required this.text,
    required this.onTap,
    required this.isLoading,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  List<Widget> _getContent() => isLoading
      ? [
          const Expanded(
            child: Center(
              child: SizedBox(
                width: AppSpacing.p20,
                height: AppSpacing.p20,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ]
      : [
          AppSpacing.gapW16,
          icon,
          AppSpacing.gapW16,
          Text(text),
        ];

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
              children: _getContent(),
            ),
          ),
        ),
      ),
    );
  }
}
