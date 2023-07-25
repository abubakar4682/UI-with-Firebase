class AppException implements Exception {
  final String? message;
  final String? prefex;

  AppException([
    this.message,
    this.prefex,
  ]);

  String toStringg() {
    return '$prefex$message';
  }
}

class NoInternetException extends AppException {
  NoInternetException([String? message]) : super(message, 'No Internet');
}

class EmailAlreadyExistException extends AppException {
  EmailAlreadyExistException([String? message]) : super(message, 'No Internet');
}

class UnknownException extends AppException {
  UnknownException([String? message]) : super(message, 'No Internet');
}

class WrongPasswordException extends AppException {
  WrongPasswordException([String? message])
      : super(message, 'Please Enter Right Password');
}

class UserNotFoundException extends AppException {
  UserNotFoundException([String? message])
      : super(message, 'This User is not Found');
}

// class FormatParsingException implements Exception {
//   final String message;
//
//   FormatParsingException(this.message);
// }
//
// class StoragePermissionDenied implements Exception {
//   final String message;
//
//   StoragePermissionDenied(this.message);
// }
//
// class StoragePermissionDeniedPermanently implements Exception {
//   final String message;
//
//   StoragePermissionDeniedPermanently(this.message);
// }
