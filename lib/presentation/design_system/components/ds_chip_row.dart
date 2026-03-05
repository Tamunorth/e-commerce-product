import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

class DsChipRow extends StatelessWidget {
  const DsChipRow({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: AppSpacing.paddingHorizontalLg,
      child: Row(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1) SizedBox(width: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}
