import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/core/router/app_router.dart';
import 'package:souqna/core/widgets/app_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Widget _buildPageIndicator({
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: isSelected ? 40 : 13,
        height: 13,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : const Color(0xFFE5E3DC),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _selectedStep = 0;

  final List<Map<String, String>> _onboardingSteps = [
    {
      'image': 'assets/images/browse.png',
      'title': 'Buy and sell around your neighborhood',
      'description':
          'Three-step intro: browse nearby, list your item, track orders in one account.',
    },
    {
      'image': 'assets/images/sell.png',
      'title': 'List items in seconds',
      'description':
          'Snap a photo, set your price, and reach buyers nearby — no separate seller account needed.',
    },
    {
      'image': 'assets/images/track.png',
      'title': 'Know exactly where your order is',
      'description':
          'Get real-time updates from Pending to Delivered, right inside the app.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              SizedBox(
                height: 450,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingSteps.length,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedStep = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final step = _onboardingSteps[index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 240,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              step['image']!,
                              width: 240,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        const Gap(12),

                        SizedBox(
                          height: 70,
                          child: Center(
                            child: Text(
                              step['title']!,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.h2,
                              maxLines: 2,
                            ),
                          ),
                        ),

                        const Gap(12),

                        SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              step['description']!,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.caption,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              const Gap(20),

              // Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_onboardingSteps.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: _buildPageIndicator(
                      isSelected: _selectedStep == index,
                      onTap: () {
                        _pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  );
                }),
              ),

              const Spacer(),

              AppButton(
                label: _selectedStep == 2 ? 'Get Started' : 'Next',
                onPressed: () {
                  if (_selectedStep == 1 || _selectedStep == 0) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    context.go(AppRouter.login);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
