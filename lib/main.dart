import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hediety/core/config/app_router.dart';
import 'package:hediety/core/config/firestore_collection.dart';
import 'package:hediety/dummy/auth_screen.dart';
import 'package:hediety/firebase_options.dart';

import '3_data_layer/local_db/local_db.dart';
import '3_data_layer/models/app_user.dart';
import 'dummy/saved_routes_screen.dart';
import '3_data_layer/models/notification.dart' as CustomNotifications;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  generateLocalDbData();
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
      // home: SavedRoutesScreen(),
      onGenerateRoute: _appRouter.generateRoute,
    );
  }
}

