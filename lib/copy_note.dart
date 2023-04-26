import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';

class CopyPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final DateTime dateTime;

  CopyPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
  });

  @override
  State<CopyPage> createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> {


// Create a DateFormat object with the desired format
  DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');


  @override
  Widget build(BuildContext context) {
    // Format the DateTime object using the DateFormat object
  String formattedDateTime = formatter.format(widget.dateTime);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.title}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${widget.subtitle}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 30,
            ),
            child: Text(
              "Yozilgan vaqt: $formattedDateTime",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
