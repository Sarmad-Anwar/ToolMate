// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslationProvider with ChangeNotifier {
  String _translatedText = '';
  bool _isLoading = false;

  String get translatedText => _translatedText;
  bool get isLoading => _isLoading;

  // Replace with your Google Translate API key
  final String apiKey = 'YOUR_GOOGLE_API_KEY';

  // Function to translate text using Google Cloud Translation API
  Future<void> translateText(String inputText, String fromLang, String toLang) async {
    if (inputText.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://translation.googleapis.com/language/translate/v2?key=$apiKey');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'q': inputText,
          'source': fromLang,
          'target': toLang,
          'format': 'text'
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _translatedText = data['data']['translations'][0]['translatedText'];
      } else {
        _translatedText = 'Error in translation';
      }
    } catch (e) {
      _translatedText = 'Failed to translate';
    }

    _isLoading = false;
    notifyListeners();
  }
}
