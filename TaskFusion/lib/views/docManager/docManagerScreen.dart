// ignore_for_file: library_private_types_in_public_api, file_names, use_build_context_synchronously, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_filex/open_filex.dart';

import '../../providers/ads_controllor.dart';

class Document {
  final String name;
  final String path;

  Document({required this.name, required this.path});

  Map<String, String> toJson() => {'name': name, 'path': path};

  static Document fromJson(Map<String, String> json) {
    return Document(name: json['name']!, path: json['path']!);
  }
}

class DocManagerScreen extends StatefulWidget {
  const DocManagerScreen({super.key});

  @override
  _DocManagerScreenState createState() => _DocManagerScreenState();
}

class _DocManagerScreenState extends State<DocManagerScreen> {
  final List<Document> _documents = [];

  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  // Load documents from local storage
  Future<void> _loadDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? docStrings = prefs.getStringList('documents');
    if (docStrings != null) {
      setState(() {
        _documents.addAll(docStrings.map((doc) {
          final json = Map<String, String>.from(Uri.splitQueryString(doc));
          return Document.fromJson(json);
        }));
      });
    }
  }

  // Save documents to local storage
  Future<void> _saveDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'documents',
        _documents.map((doc) {
          return Uri(queryParameters: doc.toJson()).query;
        }).toList());
  }

  // Add document from phone storage
  Future<void> _addDocumentFromStorage() async {
    //  final status = await AppTrackingTransparency.requestTrackingAuthorization();
    // final adController = Get.find<AdsController>();
    // if (adController.isInterstitialAdReady) {
    // Show Interstitial Ad and navigate to the appropriate screen after it closes
    // adController.showInterstitialAd(onComplete: () async {
    //   // After the ad is closed, navigate based on the title
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      final file = result.files.single;
      final document = Document(name: file.name, path: file.path!);
      setState(() {
        _documents.add(document);
      });
      _saveDocuments();
      //     }
      //   });
    }
  }

  // Open selected document
  Future<void> _openDocument(Document document) async {
    final result = await OpenFilex.open(document.path);
    if (result.type != ResultType.done) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cannot open this document type')),
      );
    }
  }

  void _removeDocument(int index) {
    setState(() {
      _documents.removeAt(index);
    });
    _saveDocuments();
  }

  // Get the icon for the document based on file extension
  Icon _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red);
      case 'doc':
      case 'docx':
        return const Icon(Icons.description, color: Colors.blue);
      case 'xls':
      case 'xlsx':
        return const Icon(Icons.table_chart, color: Colors.green);
      case 'ppt':
      case 'pptx':
        return const Icon(Icons.slideshow, color: Colors.orange);
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return const Icon(Icons.image, color: Colors.purple);
      case 'mp3':
      case 'wav':
        return const Icon(Icons.music_note, color: Colors.deepOrange);
      case 'mp4':
      case 'avi':
      case 'mkv':
        return const Icon(Icons.movie, color: Colors.indigo);
      case 'txt':
        return const Icon(Icons.text_snippet, color: Colors.grey);
      default:
        return const Icon(Icons.insert_drive_file, color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AdsController());
    AdsController adcontroller = Get.put(AdsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Manager'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addDocumentFromStorage,
          ),
        ],
      ),
      body: _documents.isEmpty
          ? const Center(
              child: Text(
                'No documents available. Tap the + button to add a document.',
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: _documents.length,
              itemBuilder: (context, index) {
                final document = _documents[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: _getFileIcon(document.name),
                    title: Text(document.name),
                    onTap: () => _openDocument(document),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeDocument(index),
                    ),
                  ),
                );
              },
            ),

      // bottomNavigationBar: Obx(() => adcontroller.isBannerAdReady
      //     ? SizedBox(
      //         width: double.infinity,
      //         height: adcontroller.bannerAd?.size.height.toDouble(),
      //         child: AdWidget(
      //           ad: adcontroller.bannerAd!,
      //         ),
      //       )
      //     : Container()),
    );
  }
}
