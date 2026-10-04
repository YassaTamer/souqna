import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/core/router/app_router.dart';
import 'package:souqna/core/widgets/app_button.dart';
import 'package:souqna/core/widgets/auth_text_field.dart';
import 'package:souqna/features/auth/cubit/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppRouter.home);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(8),
                    Text("Log In to Souqna", style: AppTextStyles.h1),
                    Gap(8),
                    Text(
                      'Access buying, selling, and orders',
                      style: AppTextStyles.caption,
                    ),
                    Gap(32),
                    AuthTextField(
                      label: "Email",
                      hintText: "you@example.com",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Gap(24),
                    AuthTextField(
                      label: "Password",
                      hintText: "••••••••",
                      controller: _passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    Gap(8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          context.push(AppRouter.forgotPassword);
                        },
                        child: Text(
                          'Forgot password?',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    isLoading: state is AuthLoading,
                    label: 'Login',
                    onPressed: () {
                      context.read<AuthCubit>().login(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    },
                  ),
                  Gap(8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.push(AppRouter.register);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.muted,
                          ),
                          children: [
                            TextSpan(text: 'New to Souqna? '),
                            TextSpan(
                              text: 'Create an account',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: AppColors.background,
        );
      },
    );
  }
}
