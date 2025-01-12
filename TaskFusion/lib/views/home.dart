// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';
import 'dart:io';
// import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:taskfusion/utils/appextenstion.dart';
import 'package:taskfusion/utils/permission_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/ads_controllor.dart';
import '../utils/appcolors.dart';
import 'NoteBook/notebookScreen.dart';
import 'Qr_Code_Screen/qr_code_screen.dart';
import 'calculator/calculatorScreen.dart';
import 'docManager/docManagerScreen.dart';
import 'timerScreen/timerScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ImagePicker _picker = ImagePicker();
  final AdsController adController = Get.find<AdsController>();
  @override
  void initState() {
    super.initState();
    tracking();
    if (!adController.isInterstitialAdReady) {
      adController.loadInterstitialAd();
    }
    // Initialize Ads Controller
    if (adController.isInterstitialAdReady) {
      adController.showInterstitialAd(onComplete: () {});
    }
  }

  Future<void> tracking() async {
    // Show tracking authorization dialog and ask for permission
    final status = await AppTrackingTransparency.requestTrackingAuthorization();
  }

  void _pickImageForEditing() async {
    try {
      // Check for permission
      PermissionStatus status = await Permission.photos.request();

      // If permission is granted, open the gallery
      if (status.isGranted) {
        final XFile? file =
            await _picker.pickImage(source: ImageSource.gallery);

        if (mounted && file != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProImageEditor.file(
                File(file.path),
                callbacks: ProImageEditorCallbacks(
                  onImageEditingComplete: (Uint8List bytes) async {
                    await _saveImageToGallery(bytes).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Image saved to gallery.')),
                      );
                      Navigator.pop(context);
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to save image.')),
                      );
                    });
                  },
                ),
              ),
            ),
          );
        }
      } else if (status.isDenied) {
        // If permission is denied, show a dialog
        _showPermissionDialog();
      } else if (status.isPermanentlyDenied) {
        // If permanently denied, direct to Settings
        _showSettingsDialog();
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Error'),
        content: const Text(
          'You have denied storage permission. Please allow it from Settings to use the image editor.',
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Open Settings'),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Needed'),
        content: const Text(
            'We need access to your gallery to edit images. Please grant permission to continue.'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Grant Permission'),
            onPressed: () async {
              Navigator.of(context).pop();
              await Permission.photos.request();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveImageToGallery(Uint8List imageBytes) async {
    try {
      // Create folder with app name in the gallery
      const appName = 'Player Cut Images'; // Replace with your app's name
      final Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        final Directory appDir = Directory('${externalDir.path}/$appName');
        if (!await appDir.exists()) {
          await appDir.create(recursive: true);
        }

        // Save the image to the app folder
        final String filePath =
            '${appDir.path}/edited_image_${DateTime.now().millisecondsSinceEpoch}.png';
        final File imageFile = File(filePath);
        await imageFile.writeAsBytes(imageBytes);

        // Save to gallery using ImageGallerySaver
        final result = await ImageGallerySaverPlus.saveFile(filePath);
        log('Image saved to gallery: $result');
      }
    } catch (e) {
      log('Error saving image to gallery: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AdsController());
    AdsController adcontroller = Get.put(AdsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToolMate',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            )),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  10.0.heightboxss,
                  const Text(
                    'ToolMate',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              onTap: () async {
                final Uri _url = Uri.parse(
                    'https://privacypolicyforiosapps.blogspot.com/2024/07/privacy-policy_51.html?m=1');
                // open to the privacy policy link
                if (!await launchUrl(_url)) {
                  throw Exception('Could not launch $_url');
                }
              },
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: randomColors.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () async {
              final AdsController adController = Get.find<AdsController>();

              switch (index) {
                case 0:
                  // Navigate to the first screen
                  context.route(const NoteBookScreen());
                  break;
                case 1:
                  if (!await Permission.photos.request().isGranted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Storage permission is required to continue.')),
                    );
                    return;
                  }
                  if (!await PermissionUtils(
                    context: context,
                    permission: Permission.photos,
                    permissionName: "Storage",
                  ).isAllowed) return;

                  _pickImageForEditing();

                  //   });
                  // }
                  break;
                case 2:
                  context.route(const DocManagerScreen());
                  break;
                case 3:
                  // Navigate to the fifth screen
                  context.route(const CalculatorScreen());
                  break;
                case 4:
                  context.route(const TimerScreen());
                  break;
                default:
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return QRCodeGeneratorScreen();
                    }),
                  );

                  break;
              }
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: randomColors[index],
                borderRadius: BorderRadius.circular(10),
              ),
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    mainIcons[index],
                    height: 80,
                    width: 80,
                  ),
                  10.0.heightboxss,
                  Text(
                    mainTitles[index],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
