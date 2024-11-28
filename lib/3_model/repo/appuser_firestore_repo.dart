import '../../core/config/firestore_collection.dart';
import '../firestore/general_firebase_OPs/general_crud_firestore.dart';
import '../models/app_user.dart';

class AppUserRepo {
  final GeneralCrudFirestore _generalCrudFirestore = GeneralCrudFirestore();

  Future<void> setSingleAppUser(AppUser appUser) {
    return _generalCrudFirestore.generalSetdocInAppCollection(
        FirestoreCollectionNames.usersCollection, appUser.id, appUser.toMap());
  }

  Future<AppUser> getSingleAppUser(String uid) async {
    var data = await _generalCrudFirestore.generalGetdocInAppCollection(
        FirestoreCollectionNames.usersCollection, uid);
    return AppUser.fromMap(data.data() as Map<String, dynamic>);
  }

  Future<void> updateFavouriteBoardIdsForSingleAppUser(
      {required String uid, required List<String> favouriteBoardsIds}) {
    return _generalCrudFirestore.generalUpdatedocInAppCollection(
        collectionName: FirestoreCollectionNames.usersCollection,
        docId: uid,
        docData: {"favouriteBoardsIds": favouriteBoardsIds});
  }
  Future<void> updateFcmTokenForSingleAppUser(
      {required String uid, required String fcmToken}) {
    return _generalCrudFirestore.generalUpdatedocInAppCollection(
        collectionName: FirestoreCollectionNames.usersCollection,
        docId: uid,
        docData: {"fcmToken": fcmToken});
  }

  Future<void> updateRecentSearchedPlaceIdForSingleAppUser(
      {required String uid, required List<String> recentSearchedPlaceIds}) {
    return _generalCrudFirestore.generalUpdatedocInAppCollection(
        collectionName: FirestoreCollectionNames.usersCollection,
        docId: uid,
        docData: {"recentSearchedPlaceIds": recentSearchedPlaceIds});
  }
  Future<void> updateCountryForSingleAppUser(
      {required String uid, required String countryCode}) {
    return _generalCrudFirestore.generalUpdatedocInAppCollection(
        collectionName: FirestoreCollectionNames.usersCollection,
        docId: uid,
        docData: {"companyBaseCountryCode": countryCode});
  }

  Future<void> updatePreviouslyBookedBoardsIdsForSingleAppUser(
      {required String uid, required List<String> previouslyBookedBoardsIds}) {
    return _generalCrudFirestore.generalUpdatedocInAppCollection(
        collectionName: FirestoreCollectionNames.usersCollection,
        docId: uid,
        docData: {"previouslyBookedBoardsIds": previouslyBookedBoardsIds});
  }

  Future<void> deleteSingleAppUser(String uid) async {
    return _generalCrudFirestore.generalDeletedocInAppCollection(
        FirestoreCollectionNames.usersCollection, uid);
  }
}
