import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hediety/3_data_layer/models/pledge.dart';

import '../../core/config/firestore_collection.dart';

class PledgesRepo {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> setPledge({required Pledge pledge}) async {
    return _firebaseFirestore
        .collection(FirestoreCollectionNames.pledgesCollection)
        .doc(pledge.id)
        .set(pledge.toMap());
  }

  Future<Pledge?> getSinglePledgeFromGiftId({required String giftId}) async {
    var snapshot = await _firebaseFirestore
        .collection(FirestoreCollectionNames.pledgesCollection)
        .where('giftId', isEqualTo: giftId)
        .get();
    if (snapshot.docs.isEmpty) {
      return null;
    }
    return Pledge.fromMap(snapshot.docs.first.data());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPledgesForUser(
      {required String userId}) async {
    return _firebaseFirestore
        .collection(FirestoreCollectionNames.pledgesCollection)
        .where('userId', isEqualTo: userId)
        .get();
  }
}
