import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:souqna/core/constants/app_categories.dart';
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
  // final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    //_categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    if (product != null) {
      _titleController.text = product.title;
      _priceController.text = product.price % 1 == 0
          ? product.price.toInt().toString()
          : product.price.toString();
      _descriptionController.text = product.description ?? '';
      _selectedCategory = AppCategories.values.contains(product.category)
          ? product.category
          : null;
    }
  }

  final _formKey = GlobalKey<FormState>();
  String? _selectedCategory;
  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBackAppBar(
        title: isEditMode ? 'Edit Product' : 'Add Product',
        subtitle: 'Fill in the details below',
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Column(
                    children: [
                      AppTextField(
                        label: 'Product Title',
                        hintText: 'Enter product title',
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                      ),

                      Gap(16),

                      AppDropdownField(
                        label: 'Category',
                        hintText: 'Select category',
                        items: AppCategories.values,
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Category is required';
                          }
                          return null;
                        },
                      ),

                      Gap(16),
                      AppTextField(
                        label: 'Price (EGP)',
                        hintText: 'Enter product Price (EGP)',
                        controller: _priceController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        validator: (value) {
                          final price = double.tryParse(value ?? '');
                          if (price == null || price <= 0) {
                            return 'Enter a valid price';
                          }
                          return null;
                        },
                      ),
                      Gap(16),
                      AppTextField(
                        label: 'Description',
                        hintText:
                            'Describe condition, dimensions, pickup notes...',
                        controller: _descriptionController,
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        maxLines: 6,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: AppButton(
                  label: isEditMode ? 'Save Changes' : 'Publish',
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
