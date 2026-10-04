import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/core/router/app_router.dart';
import 'package:souqna/core/widgets/app_button.dart';
import 'package:souqna/features/auth/cubit/auth_cubit.dart';
import 'package:souqna/features/profile/cubit/profile_cubit.dart';
import 'package:souqna/features/profile/presentation/widgets/profile_menu_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          context.go(AppRouter.login);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading || state is ProfileInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileError) {
                return Center(child: Text(state.message));
              }
              if (state is ProfileLoaded) {
                final profile = state.profile;
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('My Profile', style: AppTextStyles.h2),
                      Gap(6),
                      Text(
                        'Your buyer and seller account',
                        style: AppTextStyles.caption,
                      ),
                      Gap(24),
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 56,
                              backgroundColor: AppColors.background,
                              child: Lottie.network(
                                repeat: true,
                                fit: BoxFit.fill,
                                'https://lottie.host/1ffd8d58-52c1-4144-9df8-454c41a3941a/0iRPwUE8El.json',
                              ),
                            ),
                            Gap(8),
                            Text(
                              profile.fullName ?? ' ',
                              style: AppTextStyles.title,
                            ),
                            Gap(8),
                            Text(
                              profile.phoneNumber ?? " ",
                              style: AppTextStyles.caption,
                            ),
                            Gap(16),
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                border: BoxBorder.all(color: AppColors.border),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.caption,
                                  profile.bio ?? 'No bio yet',
                                ),
                              ),
                            ),
                            Gap(16),
                            ProfileMenuTile(
                              icon: Icons.edit,
                              title: 'Edit Profile',
                              subtitle: 'Update name, phone, avatar, bio',
                            ),
                            Gap(8),

                            ProfileMenuTile(
                              iconColor: AppColors.muted,
                              icon: Icons.settings,
                              title: 'Settings',
                              subtitle: 'Language, theme, notifications',
                            ),
                            Gap(16),

                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, authState) {
                                return AppButton(
                                  label: "Logout",
                                  isLoading: authState is AuthLoading,
                                  onPressed: () {
                                    context.read<AuthCubit>().logout();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
