import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    print(userCredential.user!.uid);
  }

  void signInAnonymously() async {
    UserCredential userCredential = await firebaseAuth.signInAnonymously();
    print(userCredential?.user?.uid);
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }

  void getUserId() {
    FirebaseAuth.instance.currentUser!.uid;
  }
}
