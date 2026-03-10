import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // If you have firebase_options.dart, add it here:
    // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization failed: $e. Make sure google-services.json is added and firebase is configured.");
  }

  runApp(
    const ProviderScope(
      child: UrbanGreenApp(),
    ),
  );
}

class UrbanGreenApp extends ConsumerWidget {
  const UrbanGreenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'UrbanGreen',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
