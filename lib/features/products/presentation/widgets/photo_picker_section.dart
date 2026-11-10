import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/features/products/data/models/product_photo.dart';
import 'package:souqna/features/products/presentation/widgets/photo_slot.dart';

class PhotoPickerSection extends StatelessWidget {
  const PhotoPickerSection({
    super.key,
    required this.photos,
    required this.coverIndex,
    required this.maxPhotos,
    this.errorText,
    required this.onAdd,
    required this.onRemove,
    required this.onSetCover,
    required this.onRetry,
  });
  final List<ProductPhoto> photos;
  final int coverIndex;
  final int maxPhotos;
  final String? errorText;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final ValueChanged<int> onSetCover;
  final ValueChanged<int> onRetry;
  @override
  Widget build(BuildContext context) {
    final slotCount = (photos.length + 1).clamp(3, maxPhotos).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Photos', style: AppTextStyles.title),
        Gap(16),
        GridView.count(
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(slotCount, (index) {
            if (index >= photos.length) return PhotoSlot(onTap: onAdd);
            final photo = photos[index];
            return PhotoSlot(
              photo: photo,
              isCover: index == coverIndex,
              onTap: () => photo.status == PhotoStatus.error
                  ? onRetry(index)
                  : onSetCover(index),
              onRemove: () => onRemove(index),
            );
          }),
        ),
        Gap(8),
        Text(
          'Add up to $maxPhotos photos. Tap a photo to make it the cover.',
          style: AppTextStyles.caption,
        ),
        if (errorText != null) ...[
          Gap(4),
          Text(
            errorText!,
            style: AppTextStyles.caption.copyWith(color: AppColors.error),
          ),
        ],
        Gap(8),
        const _PhotoTipsCard(),
      ],
    );
  }
}

class _PhotoTipsCard extends StatelessWidget {
  const _PhotoTipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primary.withValues(alpha: .1),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photo tips',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Use clear lighting and show real condition honestly.',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
