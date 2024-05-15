import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pass/Database/note.dart';
import 'package:pass/Database/repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemNote extends StatefulWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  State<ItemNote> createState() => _ItemNoteState();
}

class _ItemNoteState extends State<ItemNote> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, 'inf', arguments: {
          'title': widget.note.title,
          'password': widget.note.password,
          'username': widget.note.username,
          'information': widget.note.information,
          'time': widget.note.time,
          'photo': widget.note.photo
        });
      },
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: ((context) {
                deleted();
              }),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: ((context) {
                Navigator.pushNamed(context, 'add', arguments: {
                  'title': widget.note.title,
                  'id': widget.note.id,
                  'password': widget.note.password,
                  'username': widget.note.username,
                  'information': widget.note.information,
                  'time': widget.note.time,
                  'photo': widget.note.photo,
                });
              }),
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.update,
              label: 'Update',
            ),
          ],
        ),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Image.file(
                    File(widget.note.photo),
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                Center(
                    child: Text(
                  widget.note.title,
                  style: const TextStyle(color: Colors.black),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future deleted() {
    var nameitem = widget.note.title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.background,
                ),
              height: 130,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        'Are you sure delete $nameitem',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 11, 0, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(onPressed: delete, child: const Text('OK')),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
  
  delete() async {
    final note = Note(
        id: widget.note.id,
        title: widget.note.title,
        password: widget.note.password,
        photo: widget.note.photo,
        username: widget.note.username,
        information: widget.note.information,
        time: widget.note.time);
    NotesRepository.delete(note: note);
    Navigator.pushNamed(context, 'home');
  }

}
