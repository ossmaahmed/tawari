import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_icon_snackbar/flutter_icon_snackbar.dart";
import "package:http/http.dart" as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      IconSnackBar.show(
        context,
        label: jsonDecode(response.body)["message"],
        snackBarType: SnackBarType.success,
      );
      break;
    case 201:
      onSuccess();
      IconSnackBar.show(
        context,
        label: jsonDecode(response.body)["message"],
        snackBarType: SnackBarType.success,
      );
      break;
    case 400:
      IconSnackBar.show(
        context,
        label: jsonDecode(response.body)["message"],
        snackBarType: SnackBarType.fail,
      );
      break;
    case 401:
      IconSnackBar.show(
        context,
        label: jsonDecode(response.body)["message"],
        snackBarType: SnackBarType.fail,
      );
      break;
    case 404:
      IconSnackBar.show(
        context,
        label: jsonDecode(response.body)["message"],
        snackBarType: SnackBarType.alert,
      );
      break;
    case 409:
      IconSnackBar.show(
        context,
        label: jsonDecode(response.body)["message"],
        snackBarType: SnackBarType.alert,
      );
      break;
    case 500:
      IconSnackBar.show(
        context,
        label: jsonDecode(response.body)["message"],
        snackBarType: SnackBarType.fail,
      );
      break;
    default:
      IconSnackBar.show(
        context,
        label: "حدث شئٌ خاطئ، تأكد من إتصال الإنترنت لديك.",
        snackBarType: SnackBarType.fail,
      );
  }
}
