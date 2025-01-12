import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

// class PermissionUtils {
//   final Permission permission;
//   final String permissionName;
//   final BuildContext context;

//   PermissionUtils(
//       {required this.permission,
//       required this.permissionName,
//       required this.context});

//   Future<bool> get isAllowed async {
//     var startTime = DateTime.now();
//     var status = await permission.request();
//     var endTime = DateTime.now();
//     var waitTime = startTime.difference(endTime).inSeconds.abs();

//     /*   if (Platform.isIOS && status.isLimited && permission == Permission.photos) {
//       return true;
//     } */
//     String messages = "";
//     if (permission.value == Permission.location.value) {
//       messages = "Please turn on precise location.";
//     }
//     // if (!status.isGranted && (status.isDenied || status.isPermanentlyDenied)) {
//     if (/*!status.isGranted || status.isDenied || */ status
//             .isPermanentlyDenied &&
//         waitTime <= 1) {
//       var result = await showOkCancelAlertDialog(
//           context: Get.context!,
//           title: "Permission Error",
//           message:
//               "You denied permission. Please allow $permissionName permission from setting.${messages}Open setting now?",
//           okLabel: "Yes",
//           cancelLabel: "No");
//       if (result == OkCancelResult.ok) {
//         openAppSettings();
//       }
//       return false;
//     }

//     return status.isGranted;
//   }
// }
class PermissionUtils {
  final Permission permission;
  final String permissionName;
  final BuildContext context;

  PermissionUtils({
    required this.permission,
    required this.permissionName,
    required this.context,
  });

  Future<bool> get isAllowed async {
    var status = await permission.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Show a simple dialog instead of opening settings
      await showOkCancelAlertDialog(
        context: context,
        title: "Permission Required",
        message:
            "To use this feature, please allow the $permissionName permission.",
        okLabel: "Open Settings",
        cancelLabel: "Cancel",
      );

      return false;
    } else if (status.isPermanentlyDenied) {
      // Only open settings if permanently denied
      var result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: "Permission Required",
        message:
            "The $permissionName permission is permanently denied. Please allow it from Settings to continue using this feature. Would you like to open Settings now?",
        okLabel: "Yes",
        cancelLabel: "No",
      );
      if (result == OkCancelResult.ok) {
        openAppSettings();
      }
      return false;
    }

    return status.isGranted;
  }
}
