import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hediety/3_data_layer/firestore/general_firebase_OPs/general_crud_firestore.dart';
import 'package:hediety/3_data_layer/models/app_user.dart';
import 'package:hediety/core/config/firestore_collection.dart';

import '../models/event.dart';

class EventsRepo {
  final GeneralCrudFirestore _generalCrudFirestore = GeneralCrudFirestore();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  setEvent({required Event event}) {
    return _generalCrudFirestore.generalSetdocInAppCollection(
        FirestoreCollectionNames.eventsCollection, event.id, event.toMap());
  }

  deleteEvent({required String eventId}) {
    return _generalCrudFirestore.generalDeletedocInAppCollection(
        FirestoreCollectionNames.eventsCollection, eventId);
  }

  Future<List<Event>> getAllEventsForAppUser({required String uid}) async {
    var snapshot = await _firestore
        .collection(FirestoreCollectionNames.eventsCollection)
        .where('userId', isEqualTo: uid)
        .get();
    List<Event> events = [];

    for (var doc in snapshot.docs) {
      events.add(Event.fromMap(doc.data()));
    }
    return events;
  }
}
