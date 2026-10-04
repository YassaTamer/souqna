import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:souqna/core/router/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    if (!mounted) return;
    final session = Supabase.instance.client.auth.currentSession;

    session == null
        ? context.go(AppRouter.onboarding)
        : context.go(AppRouter.home);
  }

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: SvgPicture.asset('assets/images/splash_image.svg')),
    );
  }
}
