import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/core/widgets/app_button.dart';
import 'package:souqna/features/home/data/models/product_model.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });
  final ProductModel product;
  Widget _thumbnailPlaceholder() {
    return SvgPicture.asset(
      'assets/images/Product thumbnail.svg',
      fit: BoxFit.cover,
    );
  }

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        height: 112,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.border, width: 1.2),
        ),
        child: Row(
          children: [
            Gap(8),
            //  SvgPicture.asset('assets/images/Product thumbnail.svg'),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 88,
                height: 88,
                child: product.images.isEmpty
                    ? _thumbnailPlaceholder()
                    : CachedNetworkImage(
                        imageUrl: product.images[0],
                        fit: BoxFit.cover,
                        memCacheWidth: 264,
                        placeholder: (context, url) => _thumbnailPlaceholder(),
                        errorWidget: (context, url, error) =>
                            _thumbnailPlaceholder(),
                      ),
              ),
            ),
            Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: AppTextStyles.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.primary.withValues(alpha: .3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4, left: 4),
                          child: Center(
                            child: Text(
                              "Active",
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(4),
                  Text(
                    'EGP ${NumberFormat('#,##0').format(product.price)}',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Gap(8),
                  Row(
                    children: [
                      // Container(
                      //   height: 32,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(6),
                      //     border: Border.all(color: AppColors.primary),
                      //   ),
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       "Edit",
                      //       style: AppTextStyles.caption.copyWith(
                      //         color: AppColors.primary,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Gap(8),
                      // AppButton(label: "Delete", onPressed: (){}),
                      // Container(
                      //   height: 32,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(6),
                      //     border: Border.all(color: AppColors.error),
                      //   ),
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       "Delete",
                      //       style: AppTextStyles.caption.copyWith(
                      //         color: AppColors.error,
                      //       ),
                      //     ),
                      //   ),
                      //),
                      AppButton(
                        label: 'Edit',
                        type: AppButtonType.outlinePrimary,
                        width: 72,
                        height: 32,
                        onPressed: onEdit,
                      ),
                      Gap(8),
                      AppButton(
                        label: 'Delete',
                        type: AppButtonType.outlineDanger,
                        width: 72,
                        height: 32,
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(8),
          ],
        ),
      ),
    );
  }
}
