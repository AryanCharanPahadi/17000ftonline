

import 'package:flutter/material.dart';
import 'package:get/get.dart';
mixin BaseController {
  void handleError(error) {
    hideLoading();
    if (error is AppException || error is NotFoundException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message);
    } else {
      DialogHelper.showErrorDialog(description: 'An error occurred.');
    }
  }

  void showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }

  void hideLoading() {
    DialogHelper.hideLoading();
  }
}

class AppException implements Exception{
  String? message;
  String? prefix;
  String? url;


  AppException([this.message,this.prefix,this.url]);





}

class BadRequestException extends AppException{
  BadRequestException([String? message,String? url]) : super('Bad Request', url);
}
class FetchDataException extends AppException{
  FetchDataException([String? message,String? url]) : super('Unable to Process', url);
}
class TimeOutException extends AppException{
  TimeOutException([String? message,String? url]) : super('Request Time Out', url);
}
class UnauthorizedException extends AppException{
  UnauthorizedException([String? message,String? url]) : super('Unauthorized Acces', url);
}
class ApiNotResponsdingException extends AppException{
  ApiNotResponsdingException([String? message,String? url]) : super('API not responding', url);
}
class NotFoundException extends AppException{
  NotFoundException([String? message,String? url]) : super('Not Found', url);
}



class DialogHelper {
  // Show error dialog
  static void showErrorDialog({
    String title = 'Error',
    String? description = 'Something went wrong',
    String buttonText = 'Okay',
  }) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headlineMedium,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.titleLarge,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show loading
  static void showLoading([String? message, Color? spinnerColor]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: spinnerColor ?? Get.theme.primaryColor,
              ),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  // Hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  // Show snackbar
  static void showSnackBar(String message, {String title = 'Info'}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.5),
      colorText: Colors.white,
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }
}
