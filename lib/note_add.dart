import 'package:flutter/material.dart';
import 'model/model.dart';
import 'note_list.dart';

class NoteScreen extends StatefulWidget {
  final Notes note;

  const NoteScreen({super.key, required this.note});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _textEditingController;
  late NoteList _noteList;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.note.content);
    _noteList = NoteList();
    _noteList.loadNotes();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 180, 179, 179),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.access_alarms_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.dangerous),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  "Welcome to Notein",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textEditingController,
              onChanged: (content) {
                widget.note.content = content;
              },
              decoration: const InputDecoration(
                hintText: 'Write your note here',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Notes note = Notes(
            content: _textEditingController.text,
            createdAt: DateTime.now(),
          );
          await _noteList.add(note);
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
