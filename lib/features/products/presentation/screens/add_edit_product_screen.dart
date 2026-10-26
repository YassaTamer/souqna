import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/widgets/app_back_app_bar.dart';
import 'package:souqna/core/widgets/app_button.dart';
import 'package:souqna/core/widgets/app_dropdown_field.dart';
import 'package:souqna/core/widgets/app_text_field.dart';
import 'package:souqna/features/home/data/models/product_model.dart';

class AddEditProductScreen extends StatefulWidget {
  const AddEditProductScreen({super.key, this.product});
  final ProductModel? product;
  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  bool get isEditMode => widget.product != null;
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final List<String> _categories = [
    'Electronics',
    'Clothing',
    'Home & Furniture',
    'Sports',
    'Books',
    'Other',
  ];
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBackAppBar(
        title: isEditMode ? 'Edit Product' : 'Add Product',
        subtitle: 'Fill in the details below',
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  label: 'Product Title',
                  hintText: 'Enter product title',
                  controller: _titleController,
                ),

                Gap(16),

                AppDropdownField(
                  label: 'Category',
                  hintText: 'Select category',
                  items: _categories,
                  value: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),

                Gap(16),
                AppTextField(
                  label: 'Price (EGP)',
                  hintText: 'Enter product Price (EGP)',
                  controller: _priceController,
                ),
                Row(
                  children: [Expanded(child: AppButton(label: 'Publish', onPressed: () {}))],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
