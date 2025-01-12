// ignore_for_file: unused_local_variable, use_build_context_synchronously

// import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:taskfusion/utils/permission_utils.dart';
import 'providers/notesProvider.dart';
import 'providers/themeprovider.dart';
import 'providers/translatorProvider.dart';
import 'views/splashScreen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Show tracking authorization dialog and ask for permission
  final status = await AppTrackingTransparency.requestTrackingAuthorization();

  await MobileAds.instance.initialize();
// .then((InitializationStatus status) {
//     print('Initialization done: ${status.adapterStatuses}');
//     MobileAds.instance.updateRequestConfiguration(
//       RequestConfiguration(
//           tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified, testDeviceIds: <String>["b1bf6a42-7be5-4392-9079-4195d91a2fdd"]),
//     );
//   }
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Defer the permission request until after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _requestPermissions(context);
    });
  }

  // Future<void> _requestPermissions(BuildContext context) async {
  //   // For iOS, manage permissions more carefully by explaining the usage first.
  //   if (Platform.isIOS) {
  //     _showPermissionExplanation(
  //       context,
  //       'Permissions Needed',
  //       'To provide the best experience, the app needs access to your storage and camera for saving and capturing content. Please grant these permissions in the upcoming prompts.',
  //     );
  //   } else {
  //     // Request permissions directly on Android.
  //     await _requestAndroidPermissions(context);
  //   }
  // }

  // Future<void> _requestAndroidPermissions(BuildContext context) async {
  //   // Request storage permissions
  //   if (!await PermissionUtils(
  //               permission: Permission.storage,
  //               permissionName: "Storage",
  //               context: context)
  //           .isAllowed ||
  //       !await PermissionUtils(
  //               permission: Permission.manageExternalStorage,
  //               permissionName: "Storage",
  //               context: context)
  //           .isAllowed ||
  //       !await PermissionUtils(
  //               permission: Permission.camera,
  //               permissionName: "Storage",
  //               context: context)
  //           .isAllowed) {
  //     return;
  //   }
  // await _requestPermission(
  //   context,
  //   Permission.storage,
  //   'Storage Permission Needed',
  //   'The app needs access to your storage to save documents, videos, and QR codes. Please allow this permission to continue.',
  // );

  // Request manage external storage permissions (specific to Android 11 and above)
  // await _requestPermission(
  //   context,
  //   Permission.manageExternalStorage,
  //   'Manage Storage Permission Needed',
  //   'To manage files effectively, the app requires extended storage access. Please allow this permission to enable full functionality.',
  // );

  // Request camera permissions
  // await _requestPermission(
  //   context,
  //   Permission.camera,
  //   'Camera Permission Needed',
  //   'The app requires access to your camera to scan QR codes and capture images or videos. Please grant this permission to proceed.',
  // );
  // }

  // Future<void> _requestPermission(BuildContext context, Permission permission,
  //     String title, String content) async {
  //   final status = await permission.request();

  //   if (status.isDenied) {
  //     // Show dialog to retry permission request if denied
  //     _showPermissionDialog(
  //       context,
  //       title,
  //       content,
  //     );
  //   } else if (status.isPermanentlyDenied) {
  //     // Only allow navigation to settings page if the user chooses to do so.
  //     _showSettingsDialog(
  //       context,
  //       title,
  //       content,
  //     );
  //   }
  // }

  // void _showPermissionDialog(
  //     BuildContext context, String title, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: [
  //           TextButton(
  //             child: const Text("Open App Setting"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               openAppSettings();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text("Cancel"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _showSettingsDialog(BuildContext context, String title, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: [
  //           TextButton(
  //             child: const Text("Open Settings"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               // Open settings only when the user explicitly taps "Open Settings"
  //               _openAppSettings();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text("Cancel"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _showPermissionExplanation(
  //     BuildContext context, String title, String content) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: [
  //           TextButton(
  //             child: const Text("Continue"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               // After explanation, start requesting permissions
  //               _requestAndroidPermissions(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _openAppSettings() {
  //   // Open the app settings screen only if the user clicks "Open Settings"
  //   openAppSettings();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NotebookProvider()),
        // TranslationProvider
        ChangeNotifierProvider(create: (context) => TranslationProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeProvider, _) {
          return GetMaterialApp(
            title: 'ToolMate',
            theme: ThemeData(
              colorScheme: themeProvider.currentColorScheme,
              primaryColor: themeProvider.currentColorScheme.primary,
              useMaterial3: true,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: themeProvider.currentColorScheme.primary,
                shape: ShapeBorder.lerp(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                  ),
                  1,
                ),
              ),
            ),
            // Remove the debug banner

            debugShowCheckedModeBanner: false,

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
