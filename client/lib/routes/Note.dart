import 'package:flutter/material.dart';
import 'package:client/utils/Helper.dart';
import 'package:client/Api.dart';

import 'package:client/routes/Children.dart';

class Note extends StatefulWidget {
  Note({Key? key, required this.data}) : super(key: key);
  Map<String, dynamic> data;
  static const String routeName = "/Note";
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  // String name = "Trial";
  // String description = "Planetary Submission Alpha to destroy Ransom Vertigo";
  Map<String, dynamic> parent = {};
  @override
  void initState() {
    super.initState();
    //print(widget.data);
    if (widget.data.containsKey("parent")) {
      getNote(widget.data['parent']).then((data) {
        setState(() {
          parent = data;
        });
      }).catchError((error) => print(error));
    }
  }

  @override
  Widget build(BuildContext context) {
    // const title = "Wandering Helix";
    // var parent = "Limgrave";
    // var type = "Boss";
    var screenWidth = MediaQuery.of(context).size.width;
    var progressRatio = screenWidth * .25;
    var entryController = TextEditingController(text: widget.data['entry']);
    var titleController = TextEditingController(text: widget.data['title']);

    return MaterialApp(
        home: Scaffold(
      drawer: const Drawer(child: Text("Journal")),
      appBar: AppBar(
        titleSpacing: 10,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            margin: const EdgeInsets.only(top: 25.0),
            child: TextField(
              maxLength: 100,
              decoration: InputDecoration(
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              controller: titleController,
              onChanged: (str) {
                widget.data['title'] = str;
              },
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_attributes),
            splashRadius: 15,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            splashRadius: 15,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            splashRadius: 15,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(1, 40),
          child: Row(children: [
            Expanded(
              flex: 4,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: Text(parent.isEmpty ? "Journal Root" : parent['title'],
                      style: const TextStyle(color: Colors.white))),
            ),
            Expanded(
              flex: 2,
              child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      //maximumSize: Size(screenWidth * .33, 1),
                      backgroundColor: Colors.amber),
                  child: const Text("Boss?",
                      style: TextStyle(color: Colors.white))),
            ),
            OutlinedButton(
                onPressed: () {
                  postNote(widget.data).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Note(data: result)));
                  }).catchError((error) => print(error));
                },
                style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    //maximumSize: Size(screenWidth * .33, 1),
                    backgroundColor: Colors.amber),
                child: const Icon(
                  Icons.note_add,
                  color: Colors.white,
                )),
            OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Children(parent: widget.data)));
                },
                style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    //maximumSize: Size(screenWidth * .33, 1),
                    backgroundColor: Colors.amber),
                child: const Icon(
                  Icons.collections_bookmark,
                  color: Colors.white,
                ))
          ]),
        ),
      ),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: Container(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (str) {
                      widget.data['entry'] = str;
                    },
                    controller: entryController,
                  ),
                ))),
        LimitedBox(
            maxWidth: Helper.clamp(progressRatio, 150, 120),
            child: ListView(reverse: false, children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.data['progress']['complete'] =
                        widget.data['progress']['complete'] == "true"
                            ? "false"
                            : "true";
                  });
                },
                child: Text(widget.data['progress']['complete'] == "true"
                    ? "Completed!"
                    : "InProgress"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.data['progress']['deaths'] =
                          widget.data['progress']['deaths'] + 1;
                    });
                  },
                  child: Text("Deaths: ${widget.data['progress']['deaths']}"))
            ])),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            putNote(widget.data).then((result) {
              setState(() {
                widget.data = result;
              });
            }).catchError((error) => print(error));
          },
          child: const Icon(Icons.save)),
    ));
  }
}


    // return Container(
    //     padding: const EdgeInsets.all(8),
    //     alignment: const Alignment(0, -1),
    //     child: SingleChildScrollView(
    //         child: Column(children: <Widget>[
    //       Card(
    //         child: Column(
    //           children: <Widget>[Text(name), Text(description)],
    //         ),
    //       )
    //     ])));