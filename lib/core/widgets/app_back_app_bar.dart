import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';

class AppBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBackAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.actions,
  });
  final String title;
  final String subtitle;
  final List<Widget>? actions;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.background,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.surface,
            border: BoxBorder.all(color: AppColors.border),
          ),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h2),
          Text(subtitle, style: AppTextStyles.caption),
        ],
      ),
      actions: actions,
    );
  }
}
