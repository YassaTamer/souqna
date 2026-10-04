import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:intl/intl.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/features/home/cubit/products_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> categories = ['All', 'Home', 'Phones', 'Services'];
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Nearby Marketplace', style: AppTextStyles.h2),
                      Icon(Icons.notifications_outlined),
                    ],
                  ),
                  Text('Fresh finds within 5 km', style: AppTextStyles.caption),
                  Gap(16),
                  TextField(
                    decoration: InputDecoration(
                      fillColor: AppColors.surface,
                      filled: true,
                      hintText: 'Search products, services nearby',
                      hintStyle: AppTextStyles.body.copyWith(
                        color: AppColors.muted,
                      ),
                      prefixIcon: Icon(Icons.search, color: AppColors.muted),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                  Gap(16),

                  SizedBox(
                    height: 34,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == categories.length - 1 ? 0 : 8,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = index;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedCategory != index
                                      ? AppColors.border
                                      : AppColors.primary,
                                ),
                                color: selectedCategory == index
                                    ? AppColors.primary
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                    color: selectedCategory == index
                                        ? AppColors.surface
                                        : AppColors.text,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(16),
                  Expanded(
                    child: state is ProductsLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : state is ProductsLoaded
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.73,
                                ),
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              final product = state.products[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      8,
                                    ),

                                    child: CachedNetworkImage(
                                      imageUrl: product.images[0],
                                      height: 150,
                                      width: double.infinity,
                                      placeholder: (context, url) {
                                        return const SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        debugPrint('IMAGE ERROR: $error');
                                        debugPrint('IMAGE URL: $url');

                                        return const SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                    ///=====///
                                    // child: Image.network(
                                    //   product.images[0],
                                    //   height: 150,
                                    //   width: double.infinity,
                                    //   fit: BoxFit.cover,
                                    //   loadingBuilder:
                                    //       (context, child, loadingProgress) {
                                    //         if (loadingProgress == null) {
                                    //           return child;
                                    //         }
                                    //         return const SizedBox(
                                    //           height: 150,
                                    //           width: double.infinity,
                                    //           child: Center(
                                    //             child:
                                    //                 CircularProgressIndicator(
                                    //                   color: AppColors.primary,
                                    //                 ),
                                    //           ),
                                    //         );
                                    //       },
                                    //),
                                  ),
                                  Gap(4),
                                  Text(
                                    product.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.body,
                                    maxLines: 1,
                                  ),
                                  Gap(4),
                                  Text(
                                    'EGP ${NumberFormat('#,##0').format(product.price)}',
                                    style: AppTextStyles.caption,
                                  ),
                                ],
                              );
                            },
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
