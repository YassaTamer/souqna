import 'package:flutter/material.dart';
import 'package:souqna/core/router/app_router.dart';

class SouqnaApp extends StatelessWidget {
  const SouqnaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      title: "Souqna",
      routerConfig: appRouter,
    );
  }
}
