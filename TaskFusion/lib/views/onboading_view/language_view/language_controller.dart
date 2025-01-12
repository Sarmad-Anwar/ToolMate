import 'package:get/get.dart';

class LanguageController extends GetxController {
  List<String> languages = [
    "English(Us)",
    "Portuguese(Us)",
    "Greek(Us)",
    "Persian(Us)",
    "Arabic(Us)",
    "Italian(Us)",
    "German(Us)",
  ];

  int currentIndex = -1;
  updateLanguage(int index) {
    currentIndex = index;
    update();
  }
}
