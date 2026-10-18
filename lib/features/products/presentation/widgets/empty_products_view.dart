import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/core/widgets/app_button.dart';

class EmptyProductsView extends StatelessWidget {
  const EmptyProductsView({super.key, required this.onAddProduct});
  final VoidCallback onAddProduct;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Gap(32),

          Image.asset(
            'assets/images/Empty products illustration.png',
            height: 128,
            width: 128,
          ),
          Gap(32),
          Text('No products yet', style: AppTextStyles.h2),
          Gap(16),
          Text(
            'Start selling by adding your first product',
            style: AppTextStyles.caption,
          ),

          Spacer(),

          AppButton(
            label: 'Add Your First Product',
            onPressed: onAddProduct,
            height: 56,
          ),
        ],
      ),
    );
  }
}
