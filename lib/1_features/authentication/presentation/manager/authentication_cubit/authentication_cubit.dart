import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(UnAuthenticated(appIsStarting: true));
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool appIsStarting = true;
  //start the authentication stream to update ui based on it
  void startAuthenticationStream() {
    firebaseAuth.userChanges().listen((firebaseUser) {
      if (firebaseUser != null) {
        appIsStarting = false;
        emit(Authenticated(
          firebaseUser: firebaseUser,
        ));
      } else {
        emit(UnAuthenticated(appIsStarting: appIsStarting));
      }
    }, onError: (e) {
      print("error in $e");
      emit(AuthenticationError(message: e.toString()));
    });
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(Authenticating());
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError(
          message: e.message ?? "Unknown error"));
    } catch (e) {
      emit(AuthenticationError(message: e.toString()));
    }
    return false;
  }

  Future<bool> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(Authenticating());
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      //already the stream emits authenticated state
      return true;
      // emit(Authenticated(firebaseUser: userCredential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationError(
          message: e.message ?? "Unknown error"));
    } catch (e) {
      emit(AuthenticationError(message: e.toString()));
    }
    return false;
  }

  // Future<bool> signInWithGoogleAccount() async {
  //   emit(Authenticating());
  //   try {
  //     GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount!.authentication;
  //       AuthCredential credential = GoogleAuthProvider.credential(
  //           idToken: googleSignInAuthentication.idToken,
  //           accessToken: googleSignInAuthentication.accessToken);
  //       await firebaseAuth.signInWithCredential(credential);
  //       return true;
  //     } else {
  //       emit(AuthenticationError());
  //     }

  //     //already the stream emits authenticated state

  //     // emit(Authenticated(firebaseUser: userCredential.user!));
  //   } on FirebaseAuthException catch (e) {
  //     emit(AuthenticationError());
  //   } catch (e) {
  //     emit(AuthenticationError());
  //   }
  //   return false;
  // }
}
