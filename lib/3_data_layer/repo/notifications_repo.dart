import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config/firestore_collection.dart';
import '../models/notification.dart';

class NotificationsRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  setNotification(
      {required Notification notification, required String userId}) async {
    await firestore
        .collection(FirestoreCollectionNames.usersCollection)
        .doc(userId)
        .collection(FirestoreCollectionNames.notificationsCollection)
        .add(notification.toMap());
  }
}
