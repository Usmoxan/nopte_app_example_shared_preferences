import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'model/model.dart';
import 'note_list.dart';
import 'package:intl/intl_browser.dart';

class NoteScreen extends StatefulWidget {
  final Notes note;


  const NoteScreen({
    super.key,
    required this.note,

  });

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

// Create a DateFormat object with the desired format
  DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
  @override
  Widget build(BuildContext context) {
    var fullMaterialColors;
    // Format the DateTime object using the DateFormat object
    String formattedDateTime = formatter.format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
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
        ],
      ),
      body: Column(
        children: [
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
                    ),
                  ),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Edited: 8 Apr 15:22",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.access_alarm_outlined,
                      size: 17,
                      color: Colors.grey,
                    ),
                    Icon(
                      Icons.lock,
                      size: 17,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      formattedDateTime,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
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
              decoration: InputDecoration(
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
          if (_textEditingController.text.isNotEmpty &&
              _titleEditingController.text.isNotEmpty) {
            Notes note = Notes(
              title: _titleEditingController.text,
              content: _textEditingController.text,
              color: selectedColor
                  .toString()
                  .replaceAll('Color(', '')
                  .replaceAll(')', ''),
              createdAt: DateTime.now(),
              dateTimeNow: DateTime.now(),
            );
            await _noteList.add(note);
            Navigator.pop(context);
          } else {
            const snackBar = SnackBar(
              content: Text('Write text!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
