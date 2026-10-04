import 'package:flutter/material.dart';
import 'package:souqna/core/constants/app_colors.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.iconColor = AppColors.primary,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 56,
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: BoxBorder.all(color: AppColors.border),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(title),
        subtitle: Text(
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          subtitle,
        ),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
