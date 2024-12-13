import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hediety/3_data_layer/firestore/general_firebase_OPs/general_crud_firestore.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import 'package:hediety/3_data_layer/models/gift.dart';
import 'package:hediety/core/config/firestore_collection.dart';

import '../models/event.dart';

class GiftsRepo {
  final GeneralCrudFirestore _generalCrudFirestore = GeneralCrudFirestore();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  setGift({required Gift gift}) {
    return _generalCrudFirestore.generalSetdocInAppCollection(
        FirestoreCollectionNames.giftsCollection, gift.id, gift.toMap());
  }

  deleteGift({required String giftId}) {
    return _generalCrudFirestore.generalDeletedocInAppCollection(
        FirestoreCollectionNames.giftsCollection, giftId);
  }

  Future<List<Gift>> getAllGiftsForEvent({required String eventId}) async {
    var snapshot = await _firestore
        .collection(FirestoreCollectionNames.giftsCollection)
        .where('eventId', isEqualTo: eventId)
        .get();
    List<Gift> gifts = [];

    for (var doc in snapshot.docs) {
      gifts.add(Gift.fromMap(doc.data()));
    }
    return gifts;
  }

  Future<Gift> getSinglegift({required String giftId}) async {
    var snapshot = await _firestore
        .collection(FirestoreCollectionNames.giftsCollection)
        .doc(giftId)
        .get();
    return Gift.fromMap(snapshot.data() as Map<String, dynamic>);
  }
}
