import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:souqna/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:souqna/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:souqna/features/auth/presentation/screens/login_screen.dart';
import 'package:souqna/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:souqna/features/auth/presentation/screens/register_screen.dart';
import 'package:souqna/features/home/cubit/products_cubit.dart';
import 'package:souqna/features/home/data/repositories/product_repository.dart';
import 'package:souqna/features/home/presentation/screens/home_screen.dart';
import 'package:souqna/features/main_navigation/presentation/screens/main_navigation_shell.dart';
import 'package:souqna/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:souqna/features/profile/cubit/profile_cubit.dart';
import 'package:souqna/features/profile/data/repositories/profile_repository.dart';
import 'package:souqna/features/profile/presentation/screens/profile_screen.dart';
import 'package:souqna/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  static const splash = '/';
  static const home = '/home';
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const register = '/register';
  static const forgotPassword = '/forgotPassword';
  static const otpVerification = '/otpVerification';
  static const createNewPassword = '/createNewPassword';
  static const search = '/search';
  static const orders = '/orders';
  static const profile = '/profile';
}

final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _searchNavigatorKey = GlobalKey<NavigatorState>();
final _ordersNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRouter.splash,
      builder: (context, state) => const SplashScreen(),
      // builder: (context, state) => const MainNavigationShell(),
    ),

    GoRoute(path: AppRouter.login, builder: (context, state) => LoginScreen()),
    GoRoute(
      path: AppRouter.onboarding,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: AppRouter.register,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: AppRouter.forgotPassword,
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRouter.otpVerification,
      builder: (context, state) {
        final email = state.extra as String;
        return OtpVerificationScreen(email: email);
      },
    ),
    GoRoute(
      path: AppRouter.createNewPassword,
      builder: (context, state) => CreateNewPasswordScreen(),
    ),
    // GoRoute(
  
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ProductsCubit(ProductRepository())..fetchProducts(),
            ),
            BlocProvider(
              create: (context) =>
                  ProfileCubit(ProfileRepository())..fetchProfile(),
            ),
          ],
          child: MainNavigationShell(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: AppRouter.home,
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _searchNavigatorKey,
          routes: [
            GoRoute(
              path: AppRouter.search,
              builder: (context, state) => _SearchPlaceholder(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _ordersNavigatorKey,
          routes: [
            GoRoute(
              path: AppRouter.orders,
              builder: (context, state) => const _OrdersPlaceholder(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: AppRouter.profile,
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class _SearchPlaceholder extends StatelessWidget {
  const _SearchPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(child: Text('Search')),
    );
  }
}
class _OrdersPlaceholder extends StatelessWidget {
  const _OrdersPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: const Center(
        child: Text('Orders'),
      ),
    );
  }
}