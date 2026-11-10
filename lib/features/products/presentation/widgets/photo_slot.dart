import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/features/products/data/models/product_photo.dart';

class PhotoSlot extends StatelessWidget {
  const PhotoSlot({
    super.key,
    this.photo,
    this.isCover = false,
    required this.onTap,
    this.onRemove,
  });
  final ProductPhoto? photo;
  final bool isCover;
  final VoidCallback onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final current = photo;
    final isError = current?.status == PhotoStatus.error;
    final borderColor = isError
        ? AppColors.error
        : isCover
        ? AppColors.primary
        : AppColors.border;
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: (isCover || isError) ? 2 : 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: current == null ? _empty() : _filled(current),
          ),
        ),
      ),
    );
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.photo_camera_outlined, color: AppColors.muted),
        Gap(4),
        Text(
          'Add',
          style: AppTextStyles.caption.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }

  Widget _filled(ProductPhoto photo) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _image(photo),
        if (photo.status == PhotoStatus.uploading) _uploadingOverlay(),
        if (photo.status == PhotoStatus.error) _errorOverlay(),
        if (isCover) Positioned(left: 6, bottom: 6, child: _coverBadge()),
        if (onRemove != null&& photo.status != PhotoStatus.uploading)
          Positioned(top: 0, right: 0, child: _removeButton()),
      ],
    );
  }

  Widget _errorOverlay() {
    return Container(
      color: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            'Tap to retry',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _uploadingOverlay() {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
      ),
    );
  }

  Widget _image(ProductPhoto photo) {
    final path = photo.localPath;
    if (path != null) {
      return Image.file(File(path), fit: BoxFit.cover ,cacheWidth: 400,);
    }
    return CachedNetworkImage(
      imageUrl: photo.url!,
      fit: BoxFit.cover,
      memCacheWidth: 400,
      placeholder: (context, url) => const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.image_not_supported)),
    );
  }

  Widget _coverBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Cover',
        style: AppTextStyles.caption.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _removeButton() {
    return GestureDetector(
      onTap: onRemove,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, size: 14, color: Colors.white),
        ),
      ),
    );
  }
}
