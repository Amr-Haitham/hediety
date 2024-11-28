// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:io';

// import 'package:adblip_shared_lib/models/helper_models/uploaded_file_data.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:uuid/uuid.dart';

// enum StorageEntity {
//   users,
//   boards,
//   boardSubscriptions
// }

// class GeneralFirebaseStorageCrud {
//   final FirebaseStorage _storage = FirebaseStorage.instance;


//   Future<UploadedFileData> uploadFileAndroidAndIosFromLocalPath(
//       {required StorageEntity storageEntity,
//       required String localImagePath,
//       required String entityId,
//       required UploadedFileType type}) async {
//     var nameOfFile = const Uuid().v1();
//     String onlinePhotoPath =
//         "${type.name}/${storageEntity.name}/$entityId/$nameOfFile";
//     Reference reference = _storage.ref(onlinePhotoPath);

//     await reference.putFile(File(localImagePath));
//     var downloadLink = await reference.getDownloadURL();
//     return UploadedFileData(
//   /// - Returns: An [UploadedFileData] object with the storage path, URL, and file type.
//         path: onlinePhotoPath, url: downloadLink, type: type);
//   }

//   Future<void> deleteFile({
//     required String onlineFilePath,
//   }) async {
//     Reference reference = _storage.ref(onlineFilePath);
//     await reference.delete();
//   }

//   Future<List<UploadedFileData>> uploadMultipleFilesAndroidAndIosFromLocalPaths(
//       {required StorageEntity storageEntity,
//       required List<String> localImagesPaths,
//       required String entityId,
//       required UploadedFileType type}) async {
//     List<UploadedFileData> imagesData = [];
//     for (var path in localImagesPaths) {
//       imagesData.add(await uploadFileAndroidAndIosFromLocalPath(
//           storageEntity: storageEntity,
//           localImagePath: path,
//           entityId: entityId,
//           type: type));
//     }
//     return imagesData;
//   }

//   Future<String> uploadPhotoWeb(
//       {required StorageEntity storageEntity,
//       required String localImagePath,
//       required String restaurantUid,
//       required String nameOfFile}) async {
//     Uint8List blobData = await _getUintListForBlobUrlForWeb(localImagePath);

//     String onlinePhotoPath = "${storageEntity.name}/$restaurantUid/$nameOfFile";
//     Reference reference = _storage.ref('photos/$onlinePhotoPath');

//     // Upload the Uint8List data as a file to Firebase Storage
//     UploadTask uploadTask = reference.putData(blobData);
//     TaskSnapshot storageTaskSnapshot = await uploadTask;
//     String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

//     return downloadUrl;
//   }

//   Future<Uint8List> _getUintListForBlobUrlForWeb(String url) async {
//     http.Response response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       // Convert response body (blob data) to Uint8List
//       Uint8List? blobData = response.bodyBytes;
//       return blobData;
//     } else {
//       throw Exception();
//     }
//   }
// }

// // class UploadedFileData {
// //   final String path;
// //   final String url;
// //   UploadedFileData({
// //     required this.path,
// //     required this.url,
// //   });

// //   Map<String, dynamic> toMap() {
// //     return <String, dynamic>{
// //       'path': path,
// //       'url': url,
// //     };
// //   }

// //   UploadedFileData copyWith({
// //     String? path,
// //     String? url,
// //   }) {
// //     return UploadedFileData(
// //       path: path ?? this.path,
// //       url: url ?? this.url,
// //     );
// //   }

// //   factory UploadedFileData.fromMap(Map<String, dynamic> map) {
// //     return UploadedFileData(
// //       path: map['path'] as String,
// //       url: map['url'] as String,
// //     );
// //   }
// // }
