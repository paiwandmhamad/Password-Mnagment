import 'package:flutter/material.dart';
import 'package:pass/pages/home/item.dart';
import 'package:pass/Database/repository.dart';
import 'package:pass/pages/drawer/mydrawer.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

// ignore: camel_case_types
class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const mydrawer(),
      appBar: AppBar(
        title: const Center(child: Text("Password managment")),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, 'add', arguments: {'id': ''}),
                icon: const Icon(Icons.add)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: NotesRepository.getNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Empty"),
                  );
                }
                return GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    for (var note in snapshot.data!) ItemNote(note: note)
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
