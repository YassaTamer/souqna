import 'package:flutter/material.dart';
import 'package:souqna/features/home/data/models/product_model.dart';
import 'package:souqna/features/products/presentation/widgets/product_list_tile.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({
    super.key,
    required this.products,
    required this.onEdit,
    required this.onDelete,
  });
  final List<ProductModel> products;
  final ValueChanged<ProductModel> onEdit;
  final ValueChanged<ProductModel> onDelete;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductListTile(
          product: product,
          onEdit: () => onEdit(product),
          onDelete: () => onDelete(product),
        );
      },
    );
  }
}
