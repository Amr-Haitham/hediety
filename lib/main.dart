import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hediety/core/config/app_router.dart';
import 'package:hediety/firebase_options.dart';

import '1_view/dummy_pick_image/dummy_pick_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ImagePickerExample(),
      onGenerateRoute: _appRouter.generateRoute,
    );
  }
}
