import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hediety/1_view/authentication/auth_utility_functions/validation_functions.dart';
import 'package:mockito/mockito.dart';

// Mock class for FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  group('Sign In Function Test', () {
    test('Testing Sign In validators Functions',
        () async {
      // Arrange: Create mock instances
      var valueOfEmailValidation1 =
          ValidationFunctions.validateEmail('amrofficialacc@gmail.com');
      var valueOfPasswordValidation1 =
          ValidationFunctions.validatePassword('123456');
      var valueOfEmailValidation2 =
          ValidationFunctions.validateEmail('amroffic ialaccgmail.com');
      var valueOfPasswordValidation2 =
          ValidationFunctions.validatePassword('3424');
      // Assert: Check if currentUser is not null
      expect(valueOfEmailValidation1, isNull);
      expect(valueOfPasswordValidation1, isNull);

      expect(valueOfEmailValidation2, isNotNull);
      expect(valueOfPasswordValidation2, isNotNull);
    });
  });
}
