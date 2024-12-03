import 'dart:convert';

import 'package:collection/collection.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUser {
  String id;
  String name;
  String email;
  String phoneNumber;
  DateTime joinDate;
  String? fcmToken;
  AppUser(
      {required this.id,
      required this.joinDate,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.fcmToken});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'joinDate': joinDate.millisecondsSinceEpoch,
     "fcmToken": fcmToken,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        id: map['id'] as String,
        name: map['name'] as String,
        email: map['email'] as String,
        phoneNumber: map['phoneNumber'] as String,
        joinDate: DateTime.fromMillisecondsSinceEpoch(map['joinDate'] as int),
        fcmToken: map['fcmToken'] as String?);
  }


  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, joinDate: $joinDate, fcmToken: $fcmToken)';
  }

  }

