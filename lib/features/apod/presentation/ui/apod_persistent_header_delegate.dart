import 'package:flutter/material.dart';

class ApodPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  ApodPersistentHeaderDelegate({
    required String text,
    required TextStyle? textStyle,
    required double maxWidth,
    required this.child,
  }) {
    // * we render the text to get it's actual width in order to set the
    // * min and max extent value
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    )
      ..text = TextSpan(
        text: text,
        style: textStyle,
      )
      ..layout(maxWidth: maxWidth);

    _extent = textPainter.height;
  }

  late final double _extent;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => _extent;

  @override
  double get minExtent => _extent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
