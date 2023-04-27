import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nopte_app_example_shared_preferences/copy_note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'model/model.dart';
import 'note_add.dart';
import 'note_list.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  get note => null;

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late TextEditingController _titleEditingController;
  late NoteList _noteList;
  final TextEditingController _searchController = TextEditingController();
  List<Notes> _notes = [];

  @override
  void initState() {
    super.initState();
    _noteList = NoteList();
    _loadNotes();
  }

  void _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notesJson = prefs.getStringList('notes2');
    if (notesJson != null) {
      _notes = notesJson
          .map((noteJson) => Notes.fromJson(jsonDecode(noteJson)))
          .toList();
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
  void dispose() {
    _titleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Notein',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Image.asset(
            "asset/image.png",
            height: 40,
            width: 40,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.download,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _loadNotes();
              });
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 233, 240),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _searchController.text.isEmpty
                    ? _notes.length
                    : _filterNotes(_searchController.text).length,
                itemBuilder: (BuildContext context, int index) {
                  final notes = _searchController.text.isEmpty
                      ? _notes[index]
                      : _filterNotes(_searchController.text)[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CopyPage(
                                  title: notes.title!,
                                  subtitle: notes.content!,
                                  dateTime: notes.createdAt!,
                                ),
                              ));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(
                                  int.parse(notes.color!),
                                ).withAlpha(100),
                              ),
                              height: 60,
                              child: Row(
                                children: [
                                  Container(
                                    height: 58,
                                    width: 7,
                                    decoration: BoxDecoration(
                                      color: Color(
                                        int.parse(notes.color!),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(8),
                                        topLeft: Radius.circular(8),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          notes.title!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          notes.content!,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title: Text("DELETE"),
                                          content: Text("Delete the List?"),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              isDefaultAction: true,
                                              onPressed: () async {
                                                setState(() {
                                                  _notes.removeAt(index);
                                                  print(index);
                                                  Navigator.pop(context);
                                                });
                                                await saveNotes();
                                              },
                                              child: Text("Yes"),
                                            ),
                                            CupertinoDialogAction(
                                              onPressed: () {
                                                setState(() {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text("No"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 17,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Notes note = Notes(
            dateTimeNow: DateTime.now(),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                note: note,
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesJson =
        _notes.map((note) => jsonEncode(note.toJson())).toList();
    await prefs.setStringList('notes2', notesJson);
  }
}
