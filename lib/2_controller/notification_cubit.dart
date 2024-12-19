import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../3_data_layer/models/notification.dart';
import '../3_data_layer/models/notification.dart' as CustomNotifications;
import '../core/config/firestore_collection.dart';


class NotificationCubit extends Cubit<CustomNotifications.Notification?> {
  final FirebaseFirestore _firestore;
  final String userId;
  StreamSubscription? _subscription;

  NotificationCubit(this.userId)
      : _firestore = FirebaseFirestore.instance,
        super(null);

  void startListening() {
    
    _subscription = _firestore
        .collection(FirestoreCollectionNames.usersCollection)
        .doc(userId)
        .collection(FirestoreCollectionNames.notificationsCollection)
        .orderBy('createdAt', descending: true) // Get the latest notification
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final notification = CustomNotifications.Notification.fromJson(
            snapshot.docs.first.data());
        emit(notification); // Emit the latest notification
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
  }

  @override
  Future<void> close() {
    stopListening();
    return super.close();
  }
}



  void showNotificationDialog(BuildContext context, CustomNotifications. Notification notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification.title),
        content: Text(notification.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
