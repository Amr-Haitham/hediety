import 'package:firebase_auth/firebase_auth.dart';

class AuthUtils {
  static getCurrentUserUid() => FirebaseAuth.instance.currentUser!.uid;
}
