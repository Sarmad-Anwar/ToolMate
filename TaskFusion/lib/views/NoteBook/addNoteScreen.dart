// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../Models/notesModel.dart';
import '../../providers/ads_controllor.dart';
import '../../providers/notesProvider.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    Get.lazyPut(() => AdsController());
    AdsController adcontroller = Get.put(AdsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => adcontroller.isBannerAdReady
                ? SizedBox(
                    width: double.infinity,
                    height: adcontroller.bannerAd?.size.height.toDouble(),
                    child: AdWidget(
                      ad: adcontroller.bannerAd!,
                    ),
                  )
                : Container()),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Title', border: InputBorder.none),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: contentController,
                  minLines: 5,
                  decoration: const InputDecoration(
                      labelText: 'Content', border: InputBorder.none),
                  maxLines: 5,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (titleController.text.isNotEmpty &&
              contentController.text.isNotEmpty) {
            final newNote = Note(
              title: titleController.text,
              content: contentController.text,
            );

            Provider.of<NotebookProvider>(context, listen: false)
                .addNote(newNote);

            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please fill all the fields"),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
                child: Text(
              "Save",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
