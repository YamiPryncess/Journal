// ignore_for_file: file_names
import 'package:client/Api.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/Rootless.dart';
import 'package:client/widgets/NoteView.dart';
// import 'package:client/NavDrawer.dart';
// import 'package:client/Note.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  static const String routeName = "/Home";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> root = {};
  bool loading = true;
  @override
  void initState() {
    super.initState();
    getRoot().then((data) {
      root = data ?? {};
      setState(() {
        loading = false;
      });
    });
    // .catchError((error) {
    //   print(error);
    //   setState(() {
    //     loading = false;
    //   });
    // });
  }

  newRoot() {
    postRoot().then((data) {
      //Post is successful but root var isn't updated correctly yet.
      root = data ?? {}; //I'll focus on it later. todo
    }).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: const Text("Journal"),
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Root Note",
                )),
            Center(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : (root.isNotEmpty
                      ? NoteView(
                          noteData: root,
                        )
                      : Rootless(newRoot: newRoot)),
            ),
            Container(
                alignment: Alignment.topLeft,
                child: const Text("Recent Notes")),
            Container(child: Column()),
          ]),
        )));
  }
}

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("Journal")),
//         body: const Note(),
//         drawer: const NavDrawer());
//   }
// }
