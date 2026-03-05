import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DsSearchBar extends StatefulWidget {
  const DsSearchBar({
    super.key,
    required this.onChanged,
    this.hint,
    this.onClear,
    this.initialValue,
  });

  final ValueChanged<String> onChanged;
  final String? hint;
  final VoidCallback? onClear;
  final String? initialValue;

  @override
  State<DsSearchBar> createState() => _DsSearchBarState();
}

class _DsSearchBarState extends State<DsSearchBar> {
  late final TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      style: AppTypography.bodyMedium.copyWith(color: colors.onBackground),
      decoration: InputDecoration(
        hintText: widget.hint ?? 'Search...',
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: colors.onBackgroundMuted,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: colors.onBackgroundMuted,
          size: AppSpacing.xl,
        ),
        suffixIcon: _hasText
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: colors.onBackgroundMuted,
                  size: AppSpacing.xl,
                ),
                onPressed: () {
                  _controller.clear();
                  widget.onChanged('');
                  widget.onClear?.call();
                },
              )
            : null,
        filled: true,
        fillColor: colors.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: colors.primary, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}
