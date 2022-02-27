import 'package:client/widgets/NoteView.dart';
import 'package:client/Api.dart';
import 'package:flutter/material.dart';

class Children extends StatefulWidget {
  Children({Key? key, required this.parent}) : super(key: key);
  final parent;
  @override
  _ChildrenState createState() => _ChildrenState();
}

class _ChildrenState extends State<Children> {
  List<dynamic> children = [];
  @override
  void initState() {
    super.initState();
    getChildren(widget.parent['_id']).then((value) {
      setState(() {
        value.forEach((key, value) => children.add(value));
      });
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Children"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              splashRadius: 15,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              splashRadius: 15,
            ),
          ],
        ),
        drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: children.isEmpty
              ? OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: const Text(
                      "Searching for Children notes. Click to go back.",
                      style: TextStyle(color: Colors.white)))
              : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: children.length,
                            itemBuilder: (BuildContext context, int index) {
                              return NoteView(
                                  noteData: children[index], replace: true);
                            },
                          ),
                        )
                      ]),
                ),
        ));
  }
}
