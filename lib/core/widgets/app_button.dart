import 'package:flutter/material.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';

enum AppButtonType {
  primary,
  secondary,
  checkout,
  outlinePrimary,
  outlineDanger,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.width,
    this.height,
  });
  final String label;
  final VoidCallback onPressed;
  final AppButtonType type;
  final bool isLoading;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = switch (type) {
      AppButtonType.secondary => const BorderSide(
        color: AppColors.border,
        width: 1.5,
      ),
      AppButtonType.outlinePrimary => const BorderSide(
        color: AppColors.primary,
        width: 1.5,
      ),
      AppButtonType.outlineDanger => const BorderSide(
        color: AppColors.error,
        width: 1.5,
      ),
      _ => BorderSide.none,
    };
    final Color textColor = switch (type) {
      AppButtonType.primary => Colors.white,
      AppButtonType.secondary => AppColors.text,
      AppButtonType.checkout => AppColors.text,
      AppButtonType.outlinePrimary => AppColors.primary,
      AppButtonType.outlineDanger => AppColors.error,
    };
    final Color backgroundColor = switch (type) {
      AppButtonType.primary => AppColors.primary,
      AppButtonType.secondary => AppColors.surface,
      AppButtonType.checkout => AppColors.accent,
      AppButtonType.outlinePrimary => AppColors.surface,
      AppButtonType.outlineDanger => AppColors.surface,
    };
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderSide,
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              )
            : Text(
                label,
                style: AppTextStyles.body.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
                softWrap: false,
              ),
      ),
    );
  }
}
