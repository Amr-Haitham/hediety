import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../../core/consts/constant_text.dart';
import '../../../3_data/auth_service.dart';

part 'authentication_op_state.dart';

class AuthenticationOpCubit extends Cubit<AuthenticationOpState> {
  AuthenticationOpCubit() : super(AuthenticationOpInitial());
  final AuthService _authService = AuthService();
  Future<void> createAccountWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      emit(AuthenticationOpLoading());
      UserCredential userCredential = await _authService
          .createAccountWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        throw Exception();
      }
      emit(AuthenticationOpLoaded(userCredential: userCredential));
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationOpError(
          errorMessage: e.message ?? ConstantText.generalErrorMessage));
      debugPrint(e.toString());
    } catch (e) {
      //Todo: the error emit is not working, I will keep working as if it works. ) (done)
      //Todo: please provide clear error messages when you fix it, @Amr. (done)

      // print(e);

      emit(AuthenticationOpError(
          errorMessage: ConstantText.generalErrorMessage));
      debugPrint(e.toString());
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      emit(AuthenticationOpLoading());

      UserCredential userCredential = await _authService
          .signInWithEmailAndPassword(email: email, password: password);
      emit(AuthenticationOpLoaded(userCredential: userCredential));
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationOpError(
          errorMessage: e.message ?? ConstantText.generalErrorMessage));
      debugPrint(e.toString());
    } catch (e) {
      //Todo: the error emit is not working, I will keep working as if it works. ) (done)
      //Todo: please provide clear error messages when you fix it, @Amr. (done)

      // print(e);

      emit(AuthenticationOpError(
          errorMessage: ConstantText.generalErrorMessage));
      debugPrint(e.toString());
    }
  }
}
