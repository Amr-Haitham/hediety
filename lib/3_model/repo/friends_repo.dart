import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hediety/3_model/models/app_user.dart';
import 'package:hediety/3_model/models/friend.dart';

import '../../core/config/firestore_collection.dart';
import 'appuser_firestore_repo.dart';

class FriendsRepo {
  final _firestore = FirebaseFirestore.instance;
  Future<void> addFriend({required Friend friend}) async {
    return _firestore
        .collection(FirestoreCollectionNames.friendsCollection)
        .doc()
        .set(friend.toMap());
  }

  Future<List<AppUser>> getAllFriendsForAppUser({required String uid}) async {
    var snapshot = await _firestore
        .collection(FirestoreCollectionNames.friendsCollection)
        .where('userId', isEqualTo: uid)
        .get();
    List<Friend> friends = [];

    for (var doc in snapshot.docs) {
      friends.add(Friend.fromMap(doc.data()));
    }
    var users = await AppUserRepo()
        .getAppUsersFromIds(ids: friends.map((e) => e.friendId).toList());
    return users;
  }
}
