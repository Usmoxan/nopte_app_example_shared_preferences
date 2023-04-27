import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/model.dart';

class NoteList {
  List<Notes> notes = [];

  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notesJson = prefs.getStringList('notes2');
    if (notesJson != null) {
      notes =
          notesJson.map((json) => Notes.fromJson(jsonDecode(json))).toList();
    }
  }

  Future<void> add(Notes note) async {
    notes.add(note);
    await saveNotes();
  }

  Future<void> edit(int index, Notes note) async {
    notes[index] = note;
    await saveNotes();
  }

  Future<void> delete(int index) async {
    notes.removeAt(index);
    await saveNotes();
  }

  Future<void> remove(String txt) async {
    notes.remove(txt);
  }

  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesJson =
        notes.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes2', notesJson);
  }
}
