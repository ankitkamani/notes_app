import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/LikedNotesController.dart';
import 'package:notes_app/controllers/homeController.dart';
import 'package:notes_app/modal/notesModal.dart';
import 'package:notes_app/views/likedNotesScreen.dart';
import 'package:notes_app/widgets/commonDialog.dart';

import '../helper/sqlHelper.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final HomeController c = Get.put(HomeController());
  final LikedNotesController lC = Get.put(LikedNotesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        title: const Text('Notes App'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const LikedNotesScreen());
              },
              icon: const Icon(Icons.favorite))
        ],
      ),
      body: FirebaseAnimatedList(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        query: c.firebaseRef,
        itemBuilder: (context, snapshot, animation, index) {
          return InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await SQLHelper.createNote(
                  snapshot.child('id').value.toString(),
                  snapshot.child("title").value.toString(),
                  snapshot.child('description').value.toString()).then((value) {
                    Get.snackbar('Like Note', 'Successfully add To Likes Note',snackPosition: SnackPosition.BOTTOM);
              });
            },
            child: Badge(
              alignment: Alignment.topLeft,
              offset: const Offset(0, -10),
              backgroundColor: Colors.transparent,
              largeSize: 30,
              label: const Icon(Icons.favorite, color: Colors.red),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Card(
                    color: Colors.orange[100],
                    child: ListTile(
                        title: Text(snapshot.child("title").value.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        subtitle: Text(
                            snapshot.child('description').value.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                onTap: () {
                                  c.titleController.text =
                                      snapshot.child("title").value.toString();
                                  c.descriptionController.text = snapshot
                                      .child('description')
                                      .value
                                      .toString();
                                  commonDialog('Update note', 'Update new', c,
                                      () {
                                    c.updateNotes(
                                        NotesModal(
                                            id: int.parse(
                                                snapshot.key.toString()),
                                            title: c.titleController.text,
                                            description:
                                                c.descriptionController.text),
                                        int.parse(snapshot.key.toString()));
                                  });
                                },
                                child: const Icon(Icons.edit)),
                            const SizedBox(
                              width: 12,
                            ),
                            InkWell(
                                onTap: () {
                                  commonDeleteDialog(
                                      'Are You Sure to Delete Note',
                                      'Yes, Delete', () {
                                    c.deleteNotes(NotesModal(
                                        id: int.parse(snapshot.key.toString()),
                                        title: snapshot
                                            .child("title")
                                            .value
                                            .toString(),
                                        description: snapshot
                                            .child('description')
                                            .value
                                            .toString()));
                                  });
                                },
                                child: const Icon(Icons.delete)),
                          ],
                        ))),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          commonDialog('Add new notes', 'Create New', c, () {
            c.addNotes(NotesModal(
                id: DateTime.now().microsecondsSinceEpoch,
                title: c.titleController.text,
                description: c.descriptionController.text));
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
