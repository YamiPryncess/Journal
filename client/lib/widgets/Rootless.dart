import 'package:flutter/material.dart';

class Rootless extends StatelessWidget {
  Rootless({Key? key, required this.newRoot}) : super(key: key);
  Function newRoot;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          newRoot();
        },
        style: OutlinedButton.styleFrom(backgroundColor: Colors.amber),
        child: Column(children: const [
          Icon(
            Icons.note_alt,
            color: Color.fromARGB(255, 226, 0, 75),
            size: 30,
          ),
          Text("Create Root Note",
              style: TextStyle(color: Color.fromARGB(255, 226, 0, 75)))
        ]));
  }
}
