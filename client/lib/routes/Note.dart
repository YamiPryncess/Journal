import 'package:flutter/material.dart';
import 'package:client/utils/Helper.dart';
import 'package:client/Api.dart';

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
    print(widget.data);
    if (widget.data.containsKey("parent")) {
      getNote(widget.data['parent']).then((data) {
        parent = data;
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
        title: TextField(
          controller: titleController,
          onChanged: (str) {
            widget.data['title'] = str;
          },
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
                  onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                child: TextField(
                  onChanged: (str) {
                    widget.data['entry'] = str;
                  },
                  controller: entryController,
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