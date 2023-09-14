// error_handling_service.dart
import 'package:get/get.dart';

class ErrorHandlingService {
  static void handleApiError(int statusCode) {
    // Handle API errors based on the status code
    Get.snackbar('Error', 'API Error: $statusCode');
  }

  static void handleOtherError(dynamic error) {
    // Handle other errors
    Get.snackbar('Error', 'Error occurred: $error');
  }
}