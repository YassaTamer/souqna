import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:souqna/core/constants/supabase_constants.dart';
import 'package:souqna/features/auth/cubit/auth_cubit.dart';
import 'package:souqna/souqna_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    publishableKey: SupabaseConstants.supabaseAnonKey,
  );
  runApp(
    BlocProvider(create: (context) => AuthCubit(), child: const SouqnaApp()),
  );
}
// lib/
// ├── main.dart
// ├── app.dart                          # الـ MaterialApp.router هنا
// │
// ├── core/                             # حاجات مشتركة بين كل الـ features
// │   ├── constants/
// │   │   ├── app_colors.dart
// │   │   ├── app_text_styles.dart
// │   │   └── supabase_constants.dart   # URLs, keys refs
// │   ├── errors/
// │   │   └── failures.dart             # Custom exceptions/failures
// │   ├── router/
// │   │   └── app_router.dart           # GoRouter config
// │   ├── services/
// │   │   └── supabase_service.dart     # تهيئة supabase client
// │   └── widgets/                      # widgets مشتركة (buttons, loaders..)
// │
// ├── features/
// │   ├── auth/
// │   │   ├── data/
// │   │   │   ├── models/
// │   │   │   └── repositories/
// │   │   ├── cubit/
// │   │   │   ├── auth_cubit.dart
// │   │   │   └── auth_state.dart
// │   │   └── presentation/
// │   │       ├── screens/
// │   │       └── widgets/
// │   │
// │   ├── products/
// │   │   ├── data/
// │   │   ├── cubit/
// │   │   └── presentation/
// │   │
// │   ├── cart/
// │   │   ├── data/
// │   │   ├── cubit/
// │   │   └── presentation/
// │   │
// │   ├── orders/
// │   │   ├── data/
// │   │   ├── cubit/
// │   │   └── presentation/
// │   │
// │   └── profile/
// │       ├── data/
// │       ├── cubit/
// │       └── presentation/
// │
// └── injection_container.dart          # get_it setup (dependency injection)