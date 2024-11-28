import 'package:cloud_firestore/cloud_firestore.dart';

class GeneralCrudFirestore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  //gets a whole collection documents
  Future<QuerySnapshot<Map<String, dynamic>>> generalGetCollection(
      String collectionName) {
    return _firebaseFirestore.collection(collectionName).get();
  }

  //set new document with new attributes in any collection
  Future<void> generalSetdocInAppCollection(
      String collectionName, String docId, Map<String, dynamic> docData) {
    return _firebaseFirestore
        .collection(collectionName)
        .doc(docId)
        .set(docData);
  }

  //update certain attributes document in any collection
  Future<void> generalUpdatedocInAppCollection(
      {required String collectionName,
      required String docId,
      required Map<String, dynamic> docData}) {
    return _firebaseFirestore
        .collection(collectionName)
        .doc(docId)
        .update(docData);
  }

  //gets a single document in any collection
  Future<DocumentSnapshot<Map<String, dynamic>?>> generalGetdocInAppCollection(
      String collectionName, String docId) {
    return _firebaseFirestore.collection(collectionName).doc(docId).get();
  }

  //gets a multiple documents in a collection after a certain collection with limit
  Future<QuerySnapshot<Map<String, dynamic>>> generalGetWithStartAfterAndLimit(
      {required String collectionName,
      required String attributeNameToOrderBy,
      required String? valueToStartAfter,
      required int limit}) {
    var query = _firebaseFirestore
        .collection(collectionName)
        .orderBy(attributeNameToOrderBy);
    if (valueToStartAfter != null) {
      return query.startAfter([valueToStartAfter]).limit(limit).get();
    } else {
      return query.limit(limit).get();
    }
  }

  //delete a single document in any collection
  Future<void> generalDeletedocInAppCollection(
      String collectionName, String docId) {
    return _firebaseFirestore.collection(collectionName).doc(docId).delete();
  }

  Future<int?> getDocumentsCountOfSingleCollection(
      {required String collectionName}) async {
    var data =
        await _firebaseFirestore.collection(collectionName).count().get();

    return data.count;
  }

  //set new document with new attributes in  collection in  collection
  Future<void> generalSetdocInAppCollectionInAppCollection(
      {required String firstCollectionName,
      required String secondCollectionName,
      required String firstDocId,
      required String secondDocId,
      required Map<String, dynamic> docData}) {
    return _firebaseFirestore
        .collection(firstCollectionName)
        .doc(firstDocId)
        .collection(secondCollectionName)
        .doc(secondDocId)
        .set(docData);
  }

  //update document with new attributes in  collection in  collection
  Future<void> generalUpdatedocInAppCollectionInAppCollection(
      {required String firstCollectionName,
      required String secondCollectionName,
      required String firstDocId,
      required String secondDocId,
      required Map<String, dynamic> docData}) {
    return _firebaseFirestore
        .collection(firstCollectionName)
        .doc(firstDocId)
        .collection(secondCollectionName)
        .doc(secondDocId)
        .update(docData);
  }

  //get document with new attributes in  collection in  collection
  Future<void> generalGetdocInAppCollectionInAppCollection(
      {required String firstCollectionName,
      required String secondCollectionName,
      required String firstDocId,
      required String secondDocId,
      required String? value,
      required int limit}) {
    return _firebaseFirestore
        .collection(firstCollectionName)
        .doc(firstDocId)
        .collection(secondCollectionName)
        .doc(secondDocId)
        .get();
  }

  //get document with new attributes in  collection in  collection
  Future<QuerySnapshot<Map<String, dynamic>>>
      generalGetInAppCollectionInAppCollectionWithStartAfterAndLimit(
          {required String firstCollectionName,
          required String secondCollectionName,
          required String firstDocId,
          required String attributeNameToOrderBy,
          required int? valueToStartAfter,
          required int limit}) {
    var query = _firebaseFirestore
        .collection(firstCollectionName)
        .doc(firstDocId)
        .collection(secondCollectionName)
        .orderBy(attributeNameToOrderBy);
    if (valueToStartAfter != null) {
      return query.startAfter([valueToStartAfter]).limit(limit).get();
    } else {
      return query.limit(limit).get();
    }
  }
}
