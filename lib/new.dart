import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nopte_app_example_shared_preferences/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchNotesPage extends StatefulWidget {
  const SearchNotesPage({Key? key}) : super(key: key);

  @override
  _SearchNotesPageState createState() => _SearchNotesPageState();
}

class _SearchNotesPageState extends State<SearchNotesPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Notes> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notesJson = prefs.getStringList('notes');
    if (notesJson != null) {
      _notes = notesJson.map((noteJson) => Notes.fromJson(jsonDecode(noteJson))).toList();
    }
    setState(() {});
  }

  List<Notes> _filterNotes(String searchText) {
    return _notes.where((note) {
      final title = note.title?.toLowerCase() ?? '';
      final content = note.content?.toLowerCase() ?? '';
      final search = searchText.toLowerCase();
      return title.contains(search) || content.contains(search);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Notes',
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() {}),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchController.text.isEmpty
            ? _notes.length
            : _filterNotes(_searchController.text).length,
        itemBuilder: (BuildContext context, int index) {
          final notes = _searchController.text.isEmpty
              ? _notes[index]
              : _filterNotes(_searchController.text)[index];
          return ListTile(
            title: Text(notes.title ?? ''),
            subtitle: Text(notes.content ?? ''),
          );
        },
      ),
    );
  }
}