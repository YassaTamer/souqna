import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/features/home/data/models/product_model.dart';
import 'package:souqna/features/products/presentation/widgets/empty_products_view.dart';
import 'package:souqna/features/products/presentation/widgets/products_list_view.dart';

class MyListingsScreen extends StatelessWidget {
  MyListingsScreen({super.key});
  final List<ProductModel> products = [
    ProductModel(
      id: '1',
      sellerId: 'user_1',
      title: 'Oak dining table',
      price: 1600,
      images: [],
      status: 'active',
    ),
    ProductModel(
      id: '2',
      sellerId: 'user_1',
      title: 'Leather bag',
      price: 700,
      images: [],
      status: 'active',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
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
            Text('My Listings', style: AppTextStyles.h2),
            Text('Manage your listings', style: AppTextStyles.caption),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: SizedBox(
                width: 36,
                height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white, size: 16),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${products.length} active listings',
                style: AppTextStyles.caption,
              ),
              Expanded(
                child: products.isEmpty
                    ? EmptyProductsView(onAddProduct: () {})
                    : ProductsListView(products: products),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
