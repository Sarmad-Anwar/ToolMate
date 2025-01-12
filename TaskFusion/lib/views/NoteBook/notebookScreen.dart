// ignore_for_file: file_names

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
// import '../../providers/ads_controllor.dart';
import '../../providers/notesProvider.dart';
// import '/utils/appextenstion.dart';
import 'addNoteScreen.dart';

class NoteBookScreen extends StatelessWidget {
  const NoteBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => AdsController());
    // AdsController adcontroller = Get.put(AdsController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Notebook'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/notebook-paper-background-1080-x-1920-7vr5kxuxtv63kwas.jpg",
                ),
                fit: BoxFit.cover)),
        child: Consumer<NotebookProvider>(
          builder: (context, notebookProvider, child) {
            return notebookProvider.notes.isEmpty
                ? Center(
                    child: Column(
                    children: [],
                  ))
                : ListView.builder(
                    itemCount: notebookProvider.notes.length,
                    itemBuilder: (context, index) {
                      final note = notebookProvider.notes[index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(note.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(note.content),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              notebookProvider.removeNote(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddNoteScreen(),
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
