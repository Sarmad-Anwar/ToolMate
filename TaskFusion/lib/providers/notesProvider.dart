// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/notesModel.dart';

class NotebookProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  NotebookProvider() {
    loadNotes();
  }

  // Load notes from SharedPreferences
  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? notesString = prefs.getString('notes');
    if (notesString != null) {
      List<dynamic> jsonNotes = jsonDecode(notesString);
      _notes = jsonNotes.map((noteMap) => Note.fromMap(noteMap)).toList();
      notifyListeners();
    }
  }

  // Add a new note
  Future<void> addNote(Note note) async {
    _notes.add(note);
    await saveNotes();
    notifyListeners();
  }

  // Remove a note
  Future<void> removeNote(int index) async {
    _notes.removeAt(index);
    await saveNotes();
    notifyListeners();
  }

  // Save notes to SharedPreferences
  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonNotes = _notes.map((note) => note.toMap()).toList();
    prefs.setString('notes', jsonEncode(jsonNotes));
  }
}
