import 'package:flutter/material.dart';
import 'package:client/Api.dart';
import 'package:client/routes/Note.dart';

class NoteView extends StatefulWidget {
  NoteView({Key? key, required this.noteData}) : super(key: key);
  Map<String, dynamic> noteData;
  Map<String, dynamic> parent = {};
  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 120,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Note(data: widget.noteData)));
        },
        child: Card(
            margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            elevation: 3,
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(widget.noteData['title']))),
      ),
    );
  }
}
