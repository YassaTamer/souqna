import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:souqna/core/constants/app_colors.dart';
import 'package:souqna/core/constants/app_text_styles.dart';
import 'package:souqna/core/router/app_router.dart';
import 'package:souqna/core/widgets/app_button.dart';
import 'package:souqna/features/auth/cubit/auth_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> textEditingControllers = List.generate(6, (
    index,
  ) {
    return TextEditingController();
  });
  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in textEditingControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (BuildContext context, state) {
        if (state is AuthSuccess) {
          context.go(AppRouter.home);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter Verification Code", style: AppTextStyles.h2),
                  Gap(8),
                  Text(
                    'We sent a 6-digit code to your email',
                    style: AppTextStyles.caption,
                  ),
                  Gap(32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: List.generate(6, (index) {
                      return SizedBox(
                        height: 48,
                        width: 48,
                        child: TextField(
                          controller: textEditingControllers[index],
                          focusNode: focusNodes[index],
                          onChanged: ((value) {
                            if (index < 5 && value.isNotEmpty) {
                              (focusNodes[index + 1].requestFocus());
                            } else if (value.isEmpty && index > 0) {
                              focusNodes[index - 1].requestFocus();
                            }
                          }),
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          cursorWidth: 2,
                          cursorColor: AppColors.primary,
                          cursorRadius: Radius.circular(12),

                          decoration: InputDecoration(
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.muted,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 1.9,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  Gap(16),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Resend Code ?',
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
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: AppButton(
                label: 'Verify',
                onPressed: () {
                  final otpCode = textEditingControllers
                      .map((c) => c.text)
                      .join();
                  context.read<AuthCubit>().verifyOtp(
                    token: otpCode,
                    email: widget.email,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
