import 'package:flutter/material.dart';

import 'model/model.dart';
import 'note_add.dart';
import 'note_list.dart';


class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late NoteList _noteList;

  @override
  void initState() {
    super.initState();
    _noteList = NoteList();
    _noteList.loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _noteList = NoteList();
                  _noteList.loadNotes();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _noteList = NoteList();
            _noteList.loadNotes();
          });
        },
        child: ListView.builder(
          itemCount: _noteList.notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _noteList.delete(index);
                    });
                  },
                  icon: const Icon(Icons.delete)),
              title: Text(_noteList.notes[index].content!),
              subtitle: Text(_noteList.notes[index].createdAt.toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NoteScreen(note: _noteList.notes[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          Notes note = Notes();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(note: note),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}