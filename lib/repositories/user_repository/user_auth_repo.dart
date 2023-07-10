import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';



class UserAuthRepository {
  final AuthRepository _authRepository = AuthRepository();

  Future<UserCredential?> signUp(
      String email,
      String password,
      ) async {
    UserCredential? userCredential;
    try {
      userCredential = await _authRepository.signUp(
        email,
        password,
      );
    } catch (e) {
      rethrow;
    }
    return userCredential;
  }

  // Future<UserCredential?> googleSignIn() async {
  //   UserCredential? userCredential;
  //   try {
  //     userCredential = await _authRepository.googleSignIn();
  //   } catch (e) {
  //     rethrow;
  //   }
  //   return userCredential;
  // }

  // Future<UserCredential?> facebookLogin() async {
  //   UserCredential? userCredential;
  //   try {
  //     userCredential = await _authRepository.facebookLogin();
  //   } catch (e) {
  //     rethrow;
  //   }
  //   return userCredential;
  // }
}

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(
      String email,
      String password,
      ) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Email already in use') {
        throw EmailAlreadyExistException('Email already in use');
      } else {
        throw UnknownException('${'Something went wrong'}${e.code} ${e.message}');
      }
    } on SocketException catch (e) {
      throw NoInternetException("No internet ${e.message}");
    } on FormatException catch (e) {
      throw FormatParsingException(
          "${'Problem to get data'} ${e.message}");
    }
    return userCredential;
  }

  Future<UserCredential> signIn(
      String email,
      String password,
      ) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //debugPrint(userCredential.user?.email.toString());
    } on SocketException catch (e) {
      log(e.message);
      throw NoInternetException("No internet ${e.message}");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'Password is not right') {
        throw WrongPasswordException('Kindly enter your right Password');
      } else if (e.code == 'This user is not find ') {
        throw UserNotFoundException('User not found');
      } else if (e.code == 'Internet Issue') {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException('Something went wrong ${e.code} ${e.message}');
      }
    } on FormatException catch (e) {
      throw FormatParsingException(
          "There was a problem in parsing data ${e.message}");
    }
    return userCredential;
  }
//
// Future<UserCredential?> googleSignIn() async {
//   UserCredential? userCredential;
//   try {
//     final GoogleSignInAccount? googleSignInAccount =
//     await GoogleSignIn().signIn();
//
//     final GoogleSignInAuthentication? googleAuth =
//     await googleSignInAccount?.authentication;
//     final credentials = GoogleAuthProvider.credential(
//       idToken: googleAuth?.idToken,
//       accessToken: googleAuth?.accessToken,
//     );
//
//     userCredential =
//     await FirebaseAuth.instance.signInWithCredential(credentials);
//   } on FirebaseAuthException catch (e) {
//     log(e.message.toString());
//     throw UnknownException('Something went wrong ${e.code} ${e.message}');
//   } on FormatException catch (e) {
//     throw FormatParsingException(
//         "There was a problem in parsing data ${e.message}");
//   } on SocketException catch (e) {
//     throw NoInternetException("No internet ${e.message}");
//   }
//   return userCredential;
// }
//
// Future<UserCredential?> facebookLogin() async {
//   UserCredential? userCredential;
//   try {
//     LoginResult loginResult = await FacebookAuth.instance.login();
//     log(loginResult.status.toString());
//     log(loginResult.message.toString());
//     if (loginResult.accessToken == null) return null;
//
//     final credentials = FacebookAuthProvider.credential(
//       loginResult.accessToken!.token,
//     );
//     userCredential = await _auth.signInWithCredential(credentials);
//     if (loginResult.status != LoginStatus.success) return null;
//   } on FirebaseAuthException catch (e) {
//     log(e.message.toString());
//     if (e.code == "account-exists-with-different-credential") {
//       String? email = e.email;
//       List<String> userSignInMethods =
//       await _auth.fetchSignInMethodsForEmail(email!);
//       for (var list in userSignInMethods) {
//         if (list == "google") {
//           throw UnknownException(
//               'Account exist with google, try to signIn with Google');
//         }
//       }
//     } else {
//       throw UnknownException(
//           '${AppStrings.wentWrong} ${e.code} ${e.message}');
//     }
//   } on FormatException catch (e) {
//     throw FormatParsingException(
//         "${AppStrings.fetchDataException} ${e.message}");
//   } on SocketException catch (e) {
//     log(e.message);
//     throw NoInternetException("No internet ${e.message}");
//   }
//   return userCredential;
// }
//
// void deleteUserAccount(String id, String userType) async {
//   try {
//     await CollectionsNames.firestoreCollection
//         .collection(CollectionsNames.usersCollection)
//         .doc(id)
//         .delete();
//     if (userType == UserType.business.name) {
//       await CollectionsNames.firestoreCollection
//           .collection(CollectionsNames.businessCollection)
//           .doc(id)
//           .delete();
//     } else {
//       await CollectionsNames.firestoreCollection
//           .collection(CollectionsNames.driverCollection)
//           .doc(id)
//           .delete();
//       await CollectionsNames.firestoreCollection
//           .collection(CollectionsNames.locationCollection)
//           .doc(id)
//           .delete();
//     }
//     CollectionsNames.firebaseAuth.currentUser?.delete();
//     if (_auth.currentUser != null) {
//       CollectionsNames.firebaseAuth.signOut();
//       FacebookAuth.instance.logOut();
//       GoogleSignIn().signOut();
//     }
//   } catch (e) {
//     log(e.toString());
//   }
// }
//
// Future<List<String>> checkAuthType(String email) async {
//   List<String> result = [];
//   try {
//     result =
//     await CollectionsNames.firebaseAuth.fetchSignInMethodsForEmail(email);
//   } on FirebaseAuthException catch (e) {
//     if (e.code == AppStrings.userNotFound) {
//       throw UserNotFoundException('User not found');
//     } else if (e.code == AppStrings.noInternet) {
//       throw SocketException("${e.code}${e.message}");
//     } else {
//       throw UnknownException('Something went wrong ${e.code} ${e.message}');
//     }
//   }
//   return result;
// }
//
// void resetPassword(String email) async {
//   try {
//     await CollectionsNames.firebaseAuth.sendPasswordResetEmail(email: email);
//   } on FirebaseAuthException catch (e) {
//     if (e.code == AppStrings.userNotFound) {
//       throw UserNotFoundException('User not found');
//     } else if (e.code == AppStrings.noInternet) {
//       throw SocketException("${e.code}${e.message}");
//     } else {
//       throw UnknownException('Something went wrong ${e.code} ${e.message}');
//     }
//   }
// }
}
class EmailAlreadyExistException implements Exception {
  final String message;

  EmailAlreadyExistException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException(this.message);
}

class WrongPasswordException implements Exception {
  final String message;

  WrongPasswordException(this.message);
}

class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);
}

class FormatParsingException implements Exception {
  final String message;

  FormatParsingException(this.message);
}

class StoragePermissionDenied implements Exception {
  final String message;

  StoragePermissionDenied(this.message);
}

class StoragePermissionDeniedPermanently implements Exception {
  final String message;

  StoragePermissionDeniedPermanently(this.message);
}