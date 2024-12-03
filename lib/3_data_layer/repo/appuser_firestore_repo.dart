import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/config/firestore_collection.dart';
import '../firestore/general_firebase_OPs/general_crud_firestore.dart';
import '../models/app_user.dart';

class AppUserRepo {
  final GeneralCrudFirestore _generalCrudFirestore = GeneralCrudFirestore();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<void> setSingleAppUser(AppUser appUser) {
    return _generalCrudFirestore.generalSetdocInAppCollection(
        FirestoreCollectionNames.usersCollection, appUser.id, appUser.toMap());
  }

  Future<AppUser> getSingleAppUser(String uid) async {
    DocumentSnapshot snapshot =
        await _generalCrudFirestore.generalGetdocInAppCollection(
            FirestoreCollectionNames.usersCollection, uid);
    return AppUser.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<List<AppUser>> getAppUsersFromIds({required List<String> ids}) async {
    QuerySnapshot snapshots = await _firebaseFirestore
        .collection(FirestoreCollectionNames.usersCollection)
        .where("id", whereIn: ids)
        .get();
    List<AppUser> users = [];

    for (var doc in snapshots.docs) {
      users.add(AppUser.fromMap(doc.data() as Map<String, dynamic>));
    }
    return users;
  }

  Future<void> updateFcmTokenForSingleAppUser(
      {required String uid, required String fcmToken}) {
    return _generalCrudFirestore.generalUpdatedocInAppCollection(
        collectionName: FirestoreCollectionNames.usersCollection,
        docId: uid,
        docData: {"fcmToken": fcmToken});
  }

  Future<void> deleteSingleAppUser(String uid) async {
    return _generalCrudFirestore.generalDeletedocInAppCollection(
        FirestoreCollectionNames.usersCollection, uid);
  }
}
