import 'package:firebase_database/firebase_database.dart';

class AppRealtimeCollections {
  static String get challengesCollection => "challenges";
}

class GeneralCrudRealtime {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  //gets a whole collection documents
  Future<DataSnapshot> generalGetCollection(String collectionName) {
    return _firebaseDatabase.ref(collectionName).get();
  }

  //set new document with new attributes in any collection
  Future<void> generalSetdocInAppCollection(
      String collectionName, String docId, Map<String, dynamic> docData) {
    return _firebaseDatabase.ref(collectionName).child(docId).set(docData);
  }

  //update certain attributes document in any collection
  Future<void> generalUpdatedocInAppCollection(
      {required String collectionName,
      required String docId,
      required Map<String, dynamic> docData}) {
    return _firebaseDatabase.ref(collectionName).child(docId).update(docData);
  }

  //gets a single document in any collection
  Future<DataSnapshot> generalGetdocInAppCollection(
      String collectionName, String docId) {
    return _firebaseDatabase.ref(collectionName).child(docId).get();
  }

  Stream<DatabaseEvent> generalListenTodocInAppCollection(
      {required String collectionName, required String docId}) {
    return _firebaseDatabase.ref(collectionName).child(docId).onValue;
  }

  //delete a single document in any collection
  Future<void> generalDeletedocInAppCollection(
      String collectionName, String docId) {
    return _firebaseDatabase.ref(collectionName).child(docId).remove();
  }
}
