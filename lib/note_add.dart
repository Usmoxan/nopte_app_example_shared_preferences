// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'model/model.dart';
import 'note_list.dart';

class NoteScreen extends StatefulWidget {
  final Notes note;

  const NoteScreen({super.key, required this.note});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Color? selectedColor = Colors.lightGreen[300];
  late TextEditingController _textEditingController, _titleEditingController;

  late NoteList _noteList;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.note.content);
    _titleEditingController = TextEditingController(text: widget.note.title);
    _noteList = NoteList();
    _noteList.loadNotes();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _titleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fullMaterialColors;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 180, 179, 179),
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
                  icon: const Icon(Icons.home),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.access_alarms_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.dangerous),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Text(
                  "Welcome to Notein",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (var states) => selectedColor!,
                  )),
                  child: const Text(
                    '',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          OColorPicker(
                            selectedColor: selectedColor,
                            colors: primaryColorsPalette,
                            onColorChange: (color) {
                              setState(() {
                                selectedColor = color;
                                print(color
                                    .toString()
                                    .replaceAll('Color(', '')
                                    .replaceAll(')', ''));
                              });
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleEditingController,
              onChanged: (content) {
                widget.note.content = content;
              },
              decoration: const InputDecoration(
                hintText: 'Enter  note title here',
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
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
            title: _titleEditingController.text,
            content: _textEditingController.text,
            color: selectedColor
                .toString()
                .replaceAll('Color(', '')
                .replaceAll(')', ''),
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
