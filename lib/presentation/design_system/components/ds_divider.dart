import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class DsDivider extends StatelessWidget {
  const DsDivider({
    super.key,
    this.indent,
    this.color,
  });

  final double? indent;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Divider(
      height: 1,
      thickness: 1,
      indent: indent,
      endIndent: indent,
      color: color ?? colors.divider,
    );
  }
}
