import 'package:flutter/material.dart';

import '../../../../style/app_spacing.dart';
import '../../../../util/opposite_background_color.dart';

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

  List<Widget> _getContent(BuildContext context) => isLoading
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
          Text(
            text,
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).oppositeBackgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.p16),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getContent(context),
            ),
          ),
        ),
      ),
    );
  }
}
